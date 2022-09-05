function Get-TibberConsumption {
    <#
    .Synopsis
        Get the visible home(s) power consumption.
    .Description
        Calling this function will return the visible home(s) power consumption.
    .Example
        $response = Get-TibberConsumption -Last 10
        $maxCons = $response | Sort-Object -Property consumption -Descending | Select-Object -First 1
        Write-Host "Max power consumption $($maxCons.cost) $($maxCons.currency) ($($maxCons.consumption) $($maxCons.consumptionUnit) at $($maxCons.unitPrice)): $(([DateTime]$maxCons.from).ToString('HH:mm')) - $(([DateTime]$maxCons.to).ToString('HH:mm on yyyy-MM-dd'))"
    .Link
        Invoke-TibberGraphQLQuery
    .Link
        https://developer.tibber.com/docs/reference#consumption
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
        $dynamicParameters = Invoke-TibberGraphQLQuery -DynamicParameter
        return $dynamicParameters
    }

    process {
        # Construct the GraphQL query arguments
        $arguments = "resolution:$Resolution, last:$Last"
        if ($FilterEmptyNodes.IsPresent) { $arguments += ", filterEmptyNodes:true" }

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
        $query += "consumption($arguments){ nodes{ $Fields, __typename } }"
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
        $out = Invoke-TibberGraphQLQuery @splat

        # Output the object
        $out.viewer.$homeNode.consumption.nodes
    }
}
