﻿function Get-TibberConsumption {
    <#
    .Synopsis
        Get the visible home(s) power consumption.
    .Description
        Calling this function will return the visible home(s) power consumption.
    .Example
        $response = Get-TibberConsumption -Last 10
        $maxCons = $response | Sort-Object -Property consumption -Descending | Select-Object -First 1
        Write-Host "Max power consumption $($maxCons.cost) $($maxCons.currency) ($($maxCons.consumption) $($maxCons.consumptionUnit) at $($maxCons.unitPrice)): $(([DateTime]$maxCons.from).ToString('HH:mm')) - $(([DateTime]$maxCons.to).ToString('HH:mm on yyyy-MM-dd'))"
    .Example
        Get-TibberConsumption -From ([DateTime]::Now).AddHours(-10)
    .Link
        Invoke-TibberQuery
    .Link
        https://developer.tibber.com/docs/reference#consumption
    #>
    [CmdletBinding(DefaultParameterSetName = '__AllParameterSets')]
    param (
        # Specifies the home Id, e.g. '96a14971-525a-4420-aae9-e5aedaa129ff'.
        [Parameter(Mandatory = $true, ParameterSetName = 'HomeId', ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string] $HomeId,

        # Specifies the resoluton of the results.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateSet('HOURLY', 'DAILY', 'WEEKLY', 'MONTHLY', 'ANNUAL')]
        [string] $Resolution = 'HOURLY',

        # Specifies the start date for nodes to include in results.
        [Parameter(ValueFromPipelineByPropertyName)]
        [DateTime] $From,

        # Specifies the end date for nodes to include in results.
        [Parameter(ValueFromPipelineByPropertyName)]
        [DateTime] $To = [DateTime]::Now,

        # Specifies the number of nodes to include in results, counting back from the latest entry.
        [Parameter(ValueFromPipelineByPropertyName)]
        [int] $Last = 1,

        # Switch to filter out empty nodes (i.e. consumption is '0') from results.
        [switch] $FilterEmptyNodes,

        # Specifies the fields to return.
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]] $Fields = @(
            'from'
            'to'
            'unitPrice'
            'unitPriceVAT'
            'consumption'
            'consumptionUnit'
            'cost'
            'currency'
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
        } else {
            $homeNode = 'homes'
            $query += "$homeNode{ "
        }
        if ($From) {
            # date range provided, return nodes within the range
            $From = $From.ToUniversalTime()
            $splat = @{
                Hour   = ($Resolution -ne 'HOURLY' ? 0 : $From.Hour)
                Minute = 0
                Second = 0
            }
            $after = Get-Date -Date $From @splat
            $afterBase64 = [System.Convert]::ToBase64String( `
                ([System.Text.Encoding]::UTF8.GetBytes( `
                        (Get-Date -Date $after -Format s) `
                    ) `
                ) `
            )
            [int]$first = ($To.ToUniversalTime() - $From).TotalHours
            $arguments = "resolution:$Resolution, after:`"$afterBase64`", first:$first"
        } else {
            # no date range provided, return the specified number of nodes
            $arguments = "resolution:$Resolution, last:$Last"
        }
        if ($FilterEmptyNodes.IsPresent) { $arguments += ", filterEmptyNodes:true" }
        $query += "consumption($arguments){ nodes{ $($Fields -join ','),__typename } }"
        $query += "}}}" # close query

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
        $out = $out.viewer.$homeNode.consumption.nodes
        $out | Add-TypeName -PSTypeName $out.__typename -PassThru
    }
}
