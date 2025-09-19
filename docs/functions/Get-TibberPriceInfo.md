---
document type: cmdlet
external help file: PSTibber-Help.xml
HelpUri: https://developer.tibber.com/docs/reference#priceinfo
Locale: sv-SE
Module Name: PSTibber
ms.date: 09-19-2025
PlatyPS schema version: 2024-05-01
title: Get-TibberPriceInfo
---

# Get-TibberPriceInfo

## SYNOPSIS

Get the price info for visible home(s).

## SYNTAX

### __AllParameterSets (Default)

```
Get-TibberPriceInfo [-ExcludeCurrent] [-ExcludePast] [-IncludeToday] [-IncludeTomorrow]
 [-Last <int>] [-PriceResolution <string>] [-HistoricalPriceResolution <string>]
 [-Fields <string[]>] [<CommonParameters>]
```

### HomeId

```
Get-TibberPriceInfo -HomeId <string> [-ExcludeCurrent] [-ExcludePast] [-IncludeToday]
 [-IncludeTomorrow] [-Last <int>] [-PriceResolution <string>] [-HistoricalPriceResolution <string>]
 [-Fields <string[]>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Calling this function will return the price info for visible home(s).

## EXAMPLES

### EXAMPLE 1

$response = Get-TibberPriceInfo -Last 10
$maxPrice = $response | Sort-Object -Property total -Descending | Select-Object -First 1
Write-Host "Max energy price, $($maxPrice.total) $($maxPrice.currency), starting at $(([DateTime]$maxPrice.startsAt).ToString('yyyy-MM-dd HH:mm')) [$($maxPrice.level)]"

### EXAMPLE 2

$response = Get-TibberPriceInfo -IncludeToday
Write-Host "Today's energy prices: $($response | Out-String)"

### EXAMPLE 3

$response = Get-TibberPriceInfo -IncludeTomorrow
Write-Host "Tomorrow's energy prices: $($response | Out-String)"

## PARAMETERS

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

### -ExcludeCurrent

Switch to exclude current energy price from the results.

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

### -ExcludePast

Switch to exclude past energy prices from the results.

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

### -Fields

Specifies the fields to return.
https://developer.tibber.com/docs/reference#price

```yaml
Type: System.String[]
DefaultValue: >-
  @(
              'total'
              'energy'
              'tax'
              'startsAt'
              'currency'
              'level'
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

### -HistoricalPriceResolution

Specifies the resoluton of returned historical price information (applicable only when '-Last' is provided).

```yaml
Type: System.String
DefaultValue: HOURLY
SupportsWildcards: false
Aliases:
- Resolution
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

### -IncludeToday

Switch to include today's energy price in the results.

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

### -IncludeTomorrow

Switch to include tomorrow's energy price in the results, available after 13:00 CET/CEST.

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

### -Last

Specifies the number of nodes to include in results, counting back from the latest entry.

```yaml
Type: System.Int32
DefaultValue: 0
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

### -PriceResolution

Specifies the resoluton of returned price information.

```yaml
Type: System.String
DefaultValue: HOURLY
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

### System.Int32

{{ Fill in the Description }}

### System.String[]

{{ Fill in the Description }}

## OUTPUTS

## NOTES

## RELATED LINKS

- [Invoke-TibberQuery](Invoke-TibberQuery.md)
- [](https://developer.tibber.com/docs/reference#priceinfo)
