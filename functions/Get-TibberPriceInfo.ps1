function Get-TibberPriceInfo {
    <#
    .Synopsis
        Get the price info for visible home(s).
    .Description
        Calling this function will return the price info for visible home(s).
    .Example
        $response = Get-TibberPriceInfo -Last 10
        $maxPrice = $response | Sort-Object -Property total -Descending | Select-Object -First 1
        Write-Host "Max energy price, $($maxPrice.total) $($maxPrice.currency), starting at $(([DateTime]$maxPrice.startsAt).ToString('yyyy-MM-dd HH:mm')) [$($maxPrice.level)]"
    .Example
        $response = Get-TibberPriceInfo -IncludeToday
        Write-Host "Todays energy prices: $($response | Out-String)"
    .Example
        $response = Get-TibberPriceInfo -IncludeTomorrow
        Write-Host "Tomorrows energy prices: $($response | Out-String)"
    .Link
        Invoke-TibberQuery
    .Link
        https://developer.tibber.com/docs/reference#priceinfo
    #>
    [CmdletBinding(DefaultParameterSetName = '__None')]
    param (
        # Specifies the home Id, e.g. '96a14971-525a-4420-aae9-e5aedaa129ff'.
        [Parameter(Mandatory = $true, ParameterSetName = 'HomeId', ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string] $HomeId,

        # Specifies the resoluton of the results.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateSet('HOURLY', 'DAILY', 'WEEKLY', 'MONTHLY', 'ANNUAL')]
        [string] $Resolution = 'HOURLY',

        # Specifies the number of nodes to include in results, counting back from the latest entry.
        [Parameter(ValueFromPipelineByPropertyName)]
        [int] $Last = 0,

        # Specifies the fields to return.
        # https://developer.tibber.com/docs/reference#price
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]] $Fields = @(
            'total'
            'energy'
            'tax'
            'startsAt'
            'currency'
            'level'
        ),

        # Switch to include todays energy price in the results.
        [switch] $IncludeToday,

        # Switch to include tomorrows energy price in the results, available after 13:00 CET/CEST.
        [switch] $IncludeTomorrow
    )

    dynamicParam {
        $dynamicParameters = Invoke-TibberQuery -DynamicParameter
        return $dynamicParameters
    }

    process {
        # Construct the GraphQL query arguments
        $arguments = "resolution:$Resolution, last:$Last"

        # Construct the GraphQL query
        $query = "{ viewer{ "
        if ($PSCmdlet.ParameterSetName -eq 'HomeId') {
            $homeNode = 'home'
            $query += "$homeNode(id:`"$HomeId`"){ "
        }
        else {
            $homeNode = 'homes'
            $query += "$homeNode{ "
        }
        $query += "currentSubscription{ priceInfo{ "
        $query += "current{ $($Fields -join ','), __typename }"
        $query += "range($arguments){ nodes{ $($Fields -join ','),__typename } } "
        if ($IncludeToday.IsPresent) {
            $query += "today{ $($Fields -join ','),__typename } "
        }
        if ($IncludeTomorrow.IsPresent) {
            $query += "tomorrow{ $($Fields -join ','),__typename } "
        }
        $query += "}}}}}" # close query

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
        $out.viewer.$homeNode.currentSubscription.priceInfo.current
        $out.viewer.$homeNode.currentSubscription.priceInfo.range.nodes
        $out.viewer.$homeNode.currentSubscription.priceInfo.today
        $out.viewer.$homeNode.currentSubscription.priceInfo.tomorrow
    }
}
