function Get-TibberUser {
    <#
    .Synopsis
        Get information about the logged-in user.
    .Description
        Calling this function will return information about the logged-in user.
    .Example
        $response = Get-TibberUser -Fields 'login', 'userId', 'name'
        Write-Host "$($response.name) <$($response.login)> with user Id $($response.userId)"
    .Link
        Invoke-TibberQuery
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
        $dynamicParameters = Invoke-TibberQuery -DynamicParameter
        return $dynamicParameters
    }

    process {
        # Construct the GraphQL query
        $query = "{ viewer{ "
        $query += "$($Fields -join ','),__typename "
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
        $out = Invoke-TibberQuery @splat

        # Output the object
        $out.viewer
    }
}
