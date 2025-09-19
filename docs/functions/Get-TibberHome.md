---
document type: cmdlet
external help file: PSTibber-Help.xml
HelpUri: https://developer.tibber.com/docs/reference#home
Locale: sv-SE
Module Name: PSTibber
ms.date: 09-19-2025
PlatyPS schema version: 2024-05-01
title: Get-TibberHome
---

# Get-TibberHome

## SYNOPSIS

Get the home(s) visible to the logged-in user.

## SYNTAX

### __AllParameterSets (Default)

```
Get-TibberHome [-Fields <string[]>] [-IncludeAddress] [-AddressFields <string[]>] [-IncludeOwner]
 [-OwnerFields <string[]>] [-IncludeMetering] [-MeteringFields <string[]>] [-IncludeSubscription]
 [-SubscriptionFields <string[]>] [-IncludeFeatures] [-FeatureFields <string[]>]
 [<CommonParameters>]
```

### HomeId

```
Get-TibberHome -HomeId <string> [-Fields <string[]>] [-IncludeAddress] [-AddressFields <string[]>]
 [-IncludeOwner] [-OwnerFields <string[]>] [-IncludeMetering] [-MeteringFields <string[]>]
 [-IncludeSubscription] [-SubscriptionFields <string[]>] [-IncludeFeatures]
 [-FeatureFields <string[]>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Calling this function will return the home(s) visible to the logged-in user.

## EXAMPLES

### EXAMPLE 1

$response = Get-TibberHome -Fields 'id', 'appNickname' -IncludeFeatures
($response | ? { $_.appNickname -eq 'Vitahuset' }).id | Tee-Object -Variable homeId

### EXAMPLE 2

$response = Get-TibberHome -Fields 'appNickname' -IncludeFeatures -Id $homeId
Write-Host "Your home, $($response.appNickname), has real-time consumption $(
    if ([bool]::Parse($response.features.realTimeConsumptionEnabled)) {
        'enabled!'
    }
    else {
        'disabled...'
    }
    )"

### EXAMPLE 3

(Get-TibberHome -Fields 'mainFuseSize' -Id $homeId).mainFuseSize

## PARAMETERS

### -AddressFields

Specifies the address fields to return (applicable when -IncludeAddress provided).
https://developer.tibber.com/docs/reference#address

```yaml
Type: System.String[]
DefaultValue: >-
  @(
              'address1'
              'address2'
              'address3'
              'city'
              'postalCode'
              'country'
              'latitude'
              'longitude'
          )
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DebugResponse

{{ Fill DebugResponse Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -FeatureFields

Specifies the feature fields to return (applicable when -IncludeFeatures provided).
https://developer.tibber.com/docs/reference#homefeatures

```yaml
Type: System.String[]
DefaultValue: >-
  @(
              'realTimeConsumptionEnabled'
          )
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Fields

Specifies the fields to return.

```yaml
Type: System.String[]
DefaultValue: >-
  @(
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
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Force

{{ Fill Force Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -HomeId

Specifies the home Id, e.g.
'96a14971-525a-4420-aae9-e5aedaa129ff'.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Id
ParameterSets:
- Name: HomeId
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IncludeAddress

Switch to include home address in results.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IncludeFeatures

Switch to include home features in results.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IncludeMetering

Switch to include metering details in results.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IncludeOwner

Switch to include home owner details in results.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IncludeSubscription

Switch to include metering details in results.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -MeteringFields

Specifies the metering fields to return (applicable when -IncludeMetering provided).
https://developer.tibber.com/docs/reference#meteringpointdata

```yaml
Type: System.String[]
DefaultValue: >-
  @(
              'consumptionEan'
              'gridCompany'
              'gridAreaCode'
              'priceAreaCode'
              'productionEan'
              'energyTaxType'
              'vatType'
              'estimatedAnnualConsumption'
          )
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -OwnerFields

Specifies the home owner fields to return (applicable when -IncludeOwner provided).
https://developer.tibber.com/docs/reference#legalentity

```yaml
Type: System.String[]
DefaultValue: >-
  @(
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
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PersonalAccessToken

{{ Fill PersonalAccessToken Description }}

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- PAT
- AccessToken
- Token
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SubscriptionFields

Specifies the metering fields to return (applicable when -IncludeMetering provided).
https://developer.tibber.com/docs/reference#meteringpointdata

```yaml
Type: System.String[]
DefaultValue: >-
  @(
              'validFrom'
              'validTo'
              'status'
              "subscriber { $OwnerFields }"
          )
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -URI

{{ Fill URI Description }}

```yaml
Type: System.Uri
DefaultValue: ''
SupportsWildcards: false
Aliases:
- URL
ParameterSets:
- Name: URI
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UserAgent

{{ Fill UserAgent Description }}

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

{{ Fill in the Description }}

### System.String[]

{{ Fill in the Description }}

## OUTPUTS

## NOTES

## RELATED LINKS

- [Invoke-TibberQuery](Invoke-TibberQuery.md)
- [](https://developer.tibber.com/docs/reference#home)
