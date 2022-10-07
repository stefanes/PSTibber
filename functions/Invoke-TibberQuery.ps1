function Invoke-TibberQuery {
    <#
    .Synopsis
        Send a request to the Tibber GraphQL API.
    .Description
        Calling this function will return a custom object with data returned from the Tibber GraphQL API.
    .Example
        $query = @"
        {
            viewer {
                homes {
                    id
                }
            }
        }
        "@
        $response = Invoke-TibberQuery -Query $query
        Write-Host "Home ID = $($response.viewer.homes[0].id)"
    .Link
        https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest
    .Link
        https://developer.tibber.com/docs/reference
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'DynamicParameter')]
    [CmdletBinding(DefaultParameterSetName = 'URI')]
    [Alias('Invoke-TibberGraphQLQuery')]
    param (
        # Specifies the URI for the request.
        [Parameter(ParameterSetName = 'URI', ValueFromPipelineByPropertyName)]
        [Alias('URL')]
        [Uri] $URI = 'https://api.tibber.com/v1-beta/gql',

        # Specifies the GraphQL query.
        [Parameter(ValueFromPipelineByPropertyName)]
        [string] $Query,

        # Specifies the content type of the request.
        [Parameter(ValueFromPipelineByPropertyName)]
        [string] $ContentType = 'application/json',

        # Specifies the access token to use for the communication.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('PAT', 'AccessToken', 'Token')]
        [string] $PersonalAccessToken = $(
            if ($script:TibberAccessTokenCache) {
                $script:TibberAccessTokenCache
            }
            elseif ($env:TIBBER_ACCESS_TOKEN) {
                $env:TIBBER_ACCESS_TOKEN
            }
        ),

        # Switch to force a refresh of any cached results.
        [switch] $Force,

        [Parameter(Mandatory = $true, ParameterSetName = 'GetDynamicParameters')]
        [Alias('DynamicParameters')]
        [switch] $DynamicParameter,

        [switch] $DebugResponse
    )

    begin {
        # Setup web request cache
        if (-Not $script:TibberWebRequestCache) {
            $script:TibberWebRequestCache = @{ }
        }

        # Cache the access token (if provided)
        if ($PersonalAccessToken) {
            $script:TibberAccessTokenCache = $PersonalAccessToken
        }

        # Setup request headers
        $headers = @{
            'Content-Type'  = $ContentType
            'Authorization' = "Bearer $PersonalAccessToken"
        }
    }

    process {
        # Return dynamic parameters for functions to inherit
        if ($PSCmdlet.ParameterSetName -eq 'GetDynamicParameters') {
            if (-not $script:InvokeTibberQueryParams) {
                $script:InvokeTibberQueryParams = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                $InvokeAzDORequest = $MyInvocation.MyCommand
                :nextInputParameter foreach ($in in @('Force', 'PersonalAccessToken', 'DebugResponse')) {
                    $script:InvokeTibberQueryParams.Add($in, [Management.Automation.RuntimeDefinedParameter]::new(
                            $InvokeAzDORequest.Parameters[$in].Name,
                            $InvokeAzDORequest.Parameters[$in].ParameterType,
                            $InvokeAzDORequest.Parameters[$in].Attributes
                        ))
                }
                foreach ($paramName in $script:InvokeTibberQueryParams.Keys) {
                    foreach ($attr in $script:InvokeTibberQueryParams[$paramName].Attributes) {
                        if ($attr.ValueFromPipeline) { $attr.ValueFromPipeline = $false }
                        if ($attr.ValueFromPipelineByPropertyName) { $attr.ValueFromPipelineByPropertyName = $false }
                    }
                }
            }
            return $script:InvokeTibberQueryParams
        }

        # Setup parameters
        $body = "{ `"query`": `"$($Query -replace '"', '\"' -replace '\r?\n', '\n')`" }"
        #                                 ^                  ^
        #                                 |                  └-- convert newlines to '\n'
        #                                 └-- '"' to '\"'
        $splat = @{
            Method        = 'POST'
            Headers       = $headers
            Body          = $body
            TimeoutSec    = 60
            ErrorVariable = 'err'
        }
        $err = @( )

        # If available, return what is in the cache
        $webRequestCacheKey = ($body -replace '\\n' -replace '[^a-zA-Z0-9]').ToLower()
        if (-Not $Force -And $script:TibberWebRequestCache.$webRequestCacheKey -And -Not $Query.Trim().StartsWith('mutation')) {
            Write-Verbose -Message ("From cache: $webRequestCacheKey")
            $out = $script:TibberWebRequestCache.$webRequestCacheKey
            return $out
        }

        # Make the request
        # Note: Using 'Invoke-WebRequest' to get the headers
        $eap = $ErrorActionPreference
        $ErrorActionPreference = 'SilentlyContinue'
        Write-Debug -Message ("Invoking web request: POST " + $URI)
        Write-Debug -Message ("GraphQL query: " + $splat.Body)
        $response = Invoke-WebRequest @splat -Uri $URI
        $responseContent = $response.Content
        if ($DebugResponse.IsPresent -And $DebugPreference -ne [Management.Automation.ActionPreference]::SilentlyContinue) {
            #                              ^
            #                              └ passing '-Debug' changes the value of $DebugPreference from its deafult value
            Write-Debug -Message "Response: $($response.StatusCode) $($response.StatusDescription)"
            Write-Debug -Message "Response content: $responseContent"
        }
        $responseContent = $responseContent | ConvertFrom-Json # Convert the response from JSON
        $responseContentType = $response.Headers.'Content-Type'
        $ErrorActionPreference = $eap

        # Check for error
        if ($err) {
            $errorMessage = @"
Failed to invoke request to:
    POST $URI

Error message:
    $($err.Message)

Exception:
    $($err.InnerException.Message)
"@
            Write-Error -Message $errorMessage -Exception $err.InnerException -Category ConnectionError
            return
        }
        if ($responseContent.PSObject.Properties['errors']) {
            $errorMessage = @"
Error(s) in response from:
    POST $URI

Response:
    Error(s):       $($responseContent.errors.message) [$($responseContent.errors.extensions.code)]
    Content-Length: $($response.Headers.'Content-Length')
    Content-Type:   $responseContentType

"@
            Write-Error -Message $errorMessage -Category ConnectionError
            return
        }

        # Output response
        if ($responseContent.PSObject.Properties['data']) {
            $responseContent = $responseContent.data
        }
        $responseContent

        # Update cache
        if (-Not $Query.Trim().StartsWith('mutation')) {
            $script:TibberWebRequestCache.$webRequestCacheKey = $responseContent
            Write-Debug -Message ("Cache entry [$webRequestCacheKey]: " + $script:TibberWebRequestCache.$webRequestCacheKey)
        }

    }
}
