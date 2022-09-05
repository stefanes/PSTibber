function Invoke-TibberGraphQLQuery {
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
        $response = Invoke-TibberGraphQLQuery -Query $query
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
        [Alias('Token', 'PAT', 'AccessToken')]
        [string] $PersonalAccessToken = $(
            if ($script:TibberAccessTokenCache.AccessToken) {
                $script:TibberAccessTokenCache.AccessToken
            }
            elseif ($env:TIBBER_ACCESS_TOKEN) {
                $env:TIBBER_ACCESS_TOKEN
            }
            else {
                '5K4MVS-OjfWhK_4yrjOlFe1F6kJXPVf7eQYggo8ebAE' # demo token
            }
        ),

        # Authentication scheme to use for the provided token.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('AuthType')]
        [ValidateSet('Bearer', 'Basic')]
        [string] $AuthorizationType = $(
            if ($script:TibberAccessTokenCache.AuthType) {
                $script:TibberAccessTokenCache.AuthType
            }
            else {
                'Bearer'
            }
        ),

        [Parameter(Mandatory, ParameterSetName = 'GetDynamicParameters')]
        [Alias('DynamicParameters')]
        [switch] $DynamicParameter
    )

    begin {
        # Cache the access token (if provided)
        if ($PersonalAccessToken) {
            $script:TibberAccessTokenCache = @{
                AccessToken = $PersonalAccessToken
                AuthType    = $AuthorizationType
            }
        }

        # Setup request headers
        $headers = @{ 'Content-Type' = $ContentType }
        if ($AuthorizationType -eq 'Bearer') {
            $headers += @{ 'Authorization' = "Bearer $PersonalAccessToken" }
        }
        else {
            $headers += @{ 'Authorization' = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($PersonalAccessToken)")) }
        }
    }

    process {
        # Return dynamic parameters for functions to inherit
        if ($PSCmdlet.ParameterSetName -eq 'GetDynamicParameters') {
            if (-not $script:InvokeTibberGraphQLQueryParams) {
                $script:InvokeTibberGraphQLQueryParams = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
                $InvokeAzDORequest = $MyInvocation.MyCommand
                :nextInputParameter foreach ($in in @('PersonalAccessToken')) {
                    $script:InvokeTibberGraphQLQueryParams.Add($in, [Management.Automation.RuntimeDefinedParameter]::new(
                            $InvokeAzDORequest.Parameters[$in].Name,
                            $InvokeAzDORequest.Parameters[$in].ParameterType,
                            $InvokeAzDORequest.Parameters[$in].Attributes
                        ))
                }
                foreach ($paramName in $script:InvokeTibberGraphQLQueryParams.Keys) {
                    foreach ($attr in $script:InvokeTibberGraphQLQueryParams[$paramName].Attributes) {
                        if ($attr.ValueFromPipeline) { $attr.ValueFromPipeline = $false }
                        if ($attr.ValueFromPipelineByPropertyName) { $attr.ValueFromPipelineByPropertyName = $false }
                    }
                }
            }
            return $script:InvokeTibberGraphQLQueryParams
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
        if ($PSVersionTable.PSVersion.Major -le 5) {
            # Additional parameters *not* supported from PowerShell version 6
            $splat += @{
                'UseBasicParsing' = $true
            }
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

        # Check for invalid response content type, unless empty (204)
        if ($response.StatusCode -ne 204) {
            if ($responseContentType -notlike '*json*') {
                # Looks like we did not get JSON back, not good...
                $errorMessage = @"
Invalid response from:
    POST $URI

Response:
    Content-Length: $($response.Headers.'Content-Length')
    Content-Type:   $responseContentType

"@
                Write-Error -Message $errorMessage -Category ConnectionError
                return
            }
        }

        # Convert the response if JSON is returned
        if ($responseContentType -like '*json*') {
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
        else {
            return $responseContent
        }
    }
}
