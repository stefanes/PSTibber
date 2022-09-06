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
        Invoke-WebRequest
    .Link
        https://developer.tibber.com/docs/reference
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'DynamicParameter')]
    [CmdletBinding(DefaultParameterSetName = 'URI')]
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
            else {
                '5K4MVS-OjfWhK_4yrjOlFe1F6kJXPVf7eQYggo8ebAE' # demo token
            }
        ),

        [Parameter(Mandatory = $true, ParameterSetName = 'GetDynamicParameters')]
        [Alias('DynamicParameters')]
        [switch] $DynamicParameter
    )

    begin {
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
                :nextInputParameter foreach ($in in @('PersonalAccessToken')) {
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
        $splat = @{
            Method        = 'POST'
            Headers       = $headers
            TimeoutSec    = 60
            ErrorVariable = 'err'
        }
        $splat += @{
            Body = "{ `"query`": `"$($Query -replace '"', '\"' -replace '\r?\n', '\n')`" }"
            #                                ^                  ^
            #                                |                  └-- convert newlines to '\n'
            #                                └-- '"' to '\"'
        }
        $err = @( )

        # Make the request
        # Note: Using 'Invoke-WebRequest' to get the headers
        $eap = $ErrorActionPreference
        $ErrorActionPreference = 'SilentlyContinue'
        Write-Debug -Message ("Invoking web request: POST " + $URI)
        Write-Debug -Message ("GraphQL query: " + $splat.Body)
        $response = Invoke-WebRequest @splat -Uri $URI
        $responseContent = $response.Content
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

        # Convert the response from JSON
        $responseContent = (ConvertFrom-Json -InputObject $responseContent)
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
        elseif ($responseContent.PSObject.Properties['data']) {
            return $responseContent.data
        }
    }
}
