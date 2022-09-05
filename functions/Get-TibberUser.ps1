function Get-TibberUser {
    <#
    .Synopsis
        Get information about the logged-in user.
    .Description
        Calling this function will return information about the logged-in user.
    .Example
        $response = Get-TibberUser -Fields 'login', 'userId', 'name'
        Write-Host "$($response.name) <$($response.login)> = $($response.userId)"
    .Link
        Invoke-TibberGraphQLQuery
    .Link
        https://developer.tibber.com/docs/reference#viewer
    #>
    param (
        # Specifies the fields to return.
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]] $Fields = @(
            'login'
            'userId'
            'name'
            'accountType'
        )
    )

    dynamicParam {
        $dynamicParameters = Invoke-TibberGraphQLQuery -DynamicParameter
        return $dynamicParameters
    }

    process {
        # Construct the GraphQL query
        $query = "{ viewer{ "
        $query += "$Fields, __typename "
        $query += "}}" # close query

        # Setup parameters
        $dynamicParametersValues = @{ }
        foreach ($key in $dynamicParameters.Keys) {
            if ($PSBoundParameters[$key]) {
                $dynamicParametersValues[$key] = $PSBoundParameters[$key]
            }
        }
        $splat = @{
            Query = $query
        } + $dynamicParametersValues

        # Call the GraphQL query API
        $out = Invoke-TibberGraphQLQuery @splat

        # Output the object
        $out.viewer
    }
}
