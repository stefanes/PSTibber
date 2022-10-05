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
        Write-Host "Today's energy prices: $($response | Out-String)"
    .Example
        $response = Get-TibberPriceInfo -IncludeTomorrow
        Write-Host "Tomorrow's energy prices: $($response | Out-String)"
    .Link
        Invoke-TibberQuery
    .Link
        https://developer.tibber.com/docs/reference#priceinfo
    #>
    [CmdletBinding(DefaultParameterSetName = '__AllParameterSets')]
    param (
        # Specifies the home Id, e.g. '96a14971-525a-4420-aae9-e5aedaa129ff'.
        [Parameter(Mandatory = $true, ParameterSetName = 'HomeId', ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string] $HomeId,

        # Switch to exclude current energy price from the results.
        [switch] $ExcludeCurrent,

        # Switch to exclude past energy prices from the results.
        [switch] $ExcludePast,

        # Switch to include today's energy price in the results.
        [switch] $IncludeToday,

        # Switch to include tomorrow's energy price in the results, available after 13:00 CET/CEST.
        [switch] $IncludeTomorrow,

        # Specifies the number of nodes to include in results, counting back from the latest entry.
        [Parameter(ValueFromPipelineByPropertyName)]
        [int] $Last = 0,

        # Specifies the resoluton of the results (applicable only when '-Last' is provided).
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateSet('HOURLY', 'DAILY', 'WEEKLY', 'MONTHLY', 'ANNUAL')]
        [string] $Resolution = 'HOURLY',

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
        )
    )

    dynamicParam {
        $dynamicParameters = Invoke-TibberQuery -DynamicParameter
        return $dynamicParameters
    }

    process {
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
        $queryHasNoNode = $true
        if (-Not $ExcludeCurrent.IsPresent -And -Not $IncludeToday.IsPresent) {
            $query += "current{ $($Fields -join ','), __typename } "
            $queryHasNoNode = $false
        }
        if ($IncludeToday.IsPresent) {
            $query += "today{ $($Fields -join ','),__typename } "
            $queryHasNoNode = $false
        }
        if ($IncludeTomorrow.IsPresent) {
            $query += "tomorrow{ $($Fields -join ','),__typename } "
            $queryHasNoNode = $false
        }
        if ($Last -gt 0 -Or $queryHasNoNode) {
            $arguments = "resolution:$Resolution, last:$Last"
            $query += "range($arguments){ nodes{ $($Fields -join ','),__typename } } "
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
        @(
            $out.viewer.$homeNode.currentSubscription.priceInfo.current
            $out.viewer.$homeNode.currentSubscription.priceInfo.range.nodes
            $out.viewer.$homeNode.currentSubscription.priceInfo.today
            $out.viewer.$homeNode.currentSubscription.priceInfo.tomorrow
        ) | ForEach-Object {
            # return onlynodes that exists in response
            if ($_) {
                $_ | Add-TypeName -PSTypeName $_.__typename -PassThru
            }
        } | Where-Object {
            if ($ExcludePast.IsPresent) {
                [DateTime]$_.startsAt -ge ([DateTime]::Now | Get-Date -Minute 0 -Second 0 -Millisecond 0)
            }
            else {
                $true # always return object
            }
        }
    }
}
