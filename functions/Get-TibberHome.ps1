function Get-TibberHome {
    <#
    .Synopsis
        Get the home(s) visible to the logged-in user.
    .Description
        Calling this function will return the home(s) visible to the logged-in user.
    .Example
        $response = Get-TibberHome -Fields 'id', 'appNickname' -IncludeFeatures
        ($response | ? { $_.appNickname -eq 'Vitahuset' }).id | Tee-Object -Variable homeId
    .Example
        $response = Get-TibberHome -Fields 'appNickname' -IncludeFeatures -Id $homeId
        Write-Host "Your home, $($response.appNickname), has real-time consumption $(
            if ([bool]::Parse($response.features.realTimeConsumptionEnabled)) {
                'enabled!'
            }
            else {
                'disabled...'
            }
            )"
    .Example
        (Get-TibberHome -Fields 'mainFuseSize' -Id $homeId).mainFuseSize
    .Link
        Invoke-TibberGraphQLQuery
    .Link
        https://developer.tibber.com/docs/reference#home
    #>
    [CmdletBinding(DefaultParameterSetName = '__None')]
    param (
        # Specifies the home Id, e.g. '96a14971-525a-4420-aae9-e5aedaa129ff'.
        [Parameter(Mandatory = $true, ParameterSetName = 'HomeId', ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string] $HomeId,

        # Specifies the fields to return.
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]] $Fields = @(
            'id'
            'timeZone'
            'appNickname'
            'appAvatar'
            'size'
            'type'
            'numberOfResidents'
            'primaryHeatingSource'
            'hasVentilationSystem'
            'mainFuseSize'
        ),

        # Switch to include home address in results.
        [switch] $IncludeAddress,
        # Specifies the address fields to return (applicable when -IncludeAddress provided).
        # https://developer.tibber.com/docs/reference#address
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]] $AddressFields = @(
            'address1'
            'address2'
            'address3'
            'city'
            'postalCode'
            'country'
            'latitude'
            'longitude'
        ),

        # Switch to include home owner details in results.
        [switch] $IncludeOwner,
        # Specifies the home owner fields to return (applicable when -IncludeOwner provided).
        # https://developer.tibber.com/docs/reference#legalentity
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]] $OwnerFields = @(
            'id'
            'firstName'
            'isCompany'
            'name'
            'middleName'
            'lastName'
            'organizationNo'
            'language'
            'contactInfo { email mobile }'
            "address { $AddressFields }"
        ),

        # Switch to include metering details in results.
        [switch] $IncludeMetering,
        # Specifies the metering fields to return (applicable when -IncludeMetering provided).
        # https://developer.tibber.com/docs/reference#meteringpointdata
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]] $MeteringFields = @(
            'consumptionEan'
            'gridCompany'
            'gridAreaCode'
            'priceAreaCode'
            'productionEan'
            'energyTaxType'
            'vatType'
            'estimatedAnnualConsumption'
        ),

        # Switch to include metering details in results.
        [switch] $IncludeSubscription,
        # Specifies the metering fields to return (applicable when -IncludeMetering provided).
        # https://developer.tibber.com/docs/reference#meteringpointdata
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]] $SubscriptionFields = @(
            'validFrom'
            'validTo'
            'status'
            "subscriber { $OwnerFields }"
        ),

        # Switch to include home features in results.
        [switch] $IncludeFeatures,
        # Specifies the feature fields to return (applicable when -IncludeFeatures provided).
        # https://developer.tibber.com/docs/reference#homefeatures
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]] $FeatureFields = @(
            'realTimeConsumptionEnabled'
        )
    )

    dynamicParam {
        $dynamicParameters = Invoke-TibberGraphQLQuery -DynamicParameter
        return $dynamicParameters
    }

    process {
        # Construct the GraphQL query
        $query = "{ viewer{ "
        if ($PSCmdlet.ParameterSetName -eq 'HomeId') {
            $homeNode = 'home'
            $query += "$homeNode(id:`"$HomeId`"){ $Fields"
        }
        else {
            $homeNode = 'homes'
            $query += "$homeNode{ $Fields"
        }
        $query += ", __typename "
        if ($IncludeAddress.IsPresent) {
            $query += "address{ $AddressFields, __typename } "
        }
        if ($IncludeOwner.IsPresent) {
            $query += "owner{ $OwnerFields, __typename } "
        }
        if ($IncludeMetering.IsPresent) {
            $query += "meteringPointData{ $MeteringFields, __typename } "
        }
        if ($IncludeSubscription.IsPresent) {
            $query += "currentSubscription{ $SubscriptionFields, __typename } "
        }
        if ($IncludeFeatures.IsPresent) {
            $query += "features{ $FeatureFields, __typename } "
        }
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
        $out.viewer.$homeNode
    }
}
