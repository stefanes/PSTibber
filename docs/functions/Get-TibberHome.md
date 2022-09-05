# Get-TibberHome

## SYNOPSIS
Get the home(s) visible to the logged-in user.

## SYNTAX

### __None (Default)
```
Get-TibberHome [-Fields <String[]>] [-IncludeAddress] [-AddressFields <String[]>] [-IncludeOwner]
 [-OwnerFields <String[]>] [-IncludeMetering] [-MeteringFields <String[]>] [-IncludeSubscription]
 [-SubscriptionFields <String[]>] [-IncludeFeatures] [-FeatureFields <String[]>]
 [-PersonalAccessToken <String>] [<CommonParameters>]
```

### HomeId
```
Get-TibberHome -HomeId <String> [-Fields <String[]>] [-IncludeAddress] [-AddressFields <String[]>]
 [-IncludeOwner] [-OwnerFields <String[]>] [-IncludeMetering] [-MeteringFields <String[]>]
 [-IncludeSubscription] [-SubscriptionFields <String[]>] [-IncludeFeatures] [-FeatureFields <String[]>]
 [-PersonalAccessToken <String>] [<CommonParameters>]
```

## DESCRIPTION
Calling this function will return the home(s) visible to the logged-in user.

## EXAMPLES

### EXAMPLE 1
```
$response = Get-TibberHome -Fields 'id', 'appNickname' -IncludeFeatures
($response | ? { $_.appNickname -eq 'Vitahuset' }).id | Tee-Object -Variable homeId
```

### EXAMPLE 2
```
$response = Get-TibberHome -Fields 'appNickname' -IncludeFeatures -Id $homeId
Write-Host "Your home, $($response.appNickname), has real-time consumption $(
    if ([bool]::Parse($response.features.realTimeConsumptionEnabled)) {
        'enabled!'
    }
    else {
        'disabled...'
    }
    )"
```

### EXAMPLE 3
```
(Get-TibberHome -Fields 'mainFuseSize' -Id $homeId).mainFuseSize
```

## PARAMETERS

### -HomeId
Specifies the home Id, e.g.
'96a14971-525a-4420-aae9-e5aedaa129ff'.

```yaml
Type: String
Parameter Sets: HomeId
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Fields
Specifies the fields to return.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @(
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
        )
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeAddress
Switch to include home address in results.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AddressFields
Specifies the address fields to return (applicable when -IncludeAddress provided).
https://developer.tibber.com/docs/reference#address

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @(
            'address1'
            'address2'
            'address3'
            'city'
            'postalCode'
            'country'
            'latitude'
            'longitude'
        )
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeOwner
Switch to include home owner details in results.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OwnerFields
Specifies the home owner fields to return (applicable when -IncludeOwner provided).
https://developer.tibber.com/docs/reference#legalentity

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @(
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
        )
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeMetering
Switch to include metering details in results.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MeteringFields
Specifies the metering fields to return (applicable when -IncludeMetering provided).
https://developer.tibber.com/docs/reference#meteringpointdata

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @(
            'consumptionEan'
            'gridCompany'
            'gridAreaCode'
            'priceAreaCode'
            'productionEan'
            'energyTaxType'
            'vatType'
            'estimatedAnnualConsumption'
        )
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeSubscription
Switch to include metering details in results.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubscriptionFields
Specifies the metering fields to return (applicable when -IncludeMetering provided).
https://developer.tibber.com/docs/reference#meteringpointdata

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @(
            'validFrom'
            'validTo'
            'status'
            "subscriber { $OwnerFields }"
        )
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeFeatures
Switch to include home features in results.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FeatureFields
Specifies the feature fields to return (applicable when -IncludeFeatures provided).
https://developer.tibber.com/docs/reference#homefeatures

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @(
            'realTimeConsumptionEnabled'
        )
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PersonalAccessToken
{{ Fill PersonalAccessToken Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: PAT, AccessToken, Token

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Invoke-TibberGraphQLQuery](Invoke-TibberGraphQLQuery.md)

[https://developer.tibber.com/docs/reference#home](https://developer.tibber.com/docs/reference#home)

