function Get-TibberHome {
    <#
    .Synopsis
        Get the home(s) visible to the logged-in user.
    .Description
        Calling this function will return the home(s) visible to the logged-in user.
    .Example
        $response = (Get-TibberHome -Fields 'id', 'appNickname' -IncludeFeatures)[0]
        Write-Host "Home '$($response.appNickname)', with Id $($response.id), has real-time consumption $(
            if ([bool]::Parse($response.features.realTimeConsumptionEnabled)) {
                'enabled!'
            }
            else {
                'disabled...'
            }
            )"
    .Link
        Invoke-TibberGraphQLQuery
    .Link
        https://developer.tibber.com/docs/reference#home
    #>
    [CmdletBinding(DefaultParameterSetName = '__None')]
    param (
        # Specifies the storage keys of user(s)/group(s).
        [Parameter(Mandatory = $true, ParameterSetName = 'ById', ValueFromPipelineByPropertyName)]
        [Alias('HomeId')]
        [string] $Id,

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
        # Specifies the address fields to return (if any).
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
        # Specifies the home owner fields to return (if any).
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
        # Specifies the metering fields to return (if any).
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

        # Switch to include home features in results.
        [switch] $IncludeFeatures,
        # Specifies the feature fields to return (if any).
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
        if ($PSCmdlet.ParameterSetName -eq 'ById') {
            $node = 'home'
            $query += "$node(id:`"$Id`"){ $Fields "
        }
        else {
            $node = 'homes'
            $query += "$node{ $Fields "
        }
        if ($IncludeAddress.IsPresent) {
            $query += "address{ $AddressFields } "
        }
        if ($IncludeOwner.IsPresent) {
            $query += "owner{ $OwnerFields } "
        }
        if ($IncludeMetering.IsPresent) {
            $query += "meteringPointData{ $MeteringFields } "
        }
        if ($IncludeFeatures.IsPresent) {
            $query += "features{ $FeatureFields } "
        }
        $query += "}}}"

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
        $out.viewer.$node
    }
}
