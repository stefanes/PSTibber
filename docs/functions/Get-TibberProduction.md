---
document type: cmdlet
external help file: PSTibber-Help.xml
HelpUri: https://developer.tibber.com/docs/reference#production
Locale: sv-SE
Module Name: PSTibber
ms.date: 09-19-2025
PlatyPS schema version: 2024-05-01
title: Get-TibberProduction
---

# Get-TibberProduction

## SYNOPSIS

Get the visible home(s) power production.

## SYNTAX

### __AllParameterSets (Default)

```
Get-TibberProduction [-Resolution <string>] [-From <datetime>] [-To <datetime>] [-Last <int>]
 [-FilterEmptyNodes] [-Fields <string[]>] [<CommonParameters>]
```

### HomeId

```
Get-TibberProduction -HomeId <string> [-Resolution <string>] [-From <datetime>] [-To <datetime>]
 [-Last <int>] [-FilterEmptyNodes] [-Fields <string[]>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Calling this function will return the visible home(s) power production.

## EXAMPLES

### EXAMPLE 1

$response = Get-TibberProduction -Last 10
$maxProd = $response | Sort-Object -Property production -Descending | Select-Object -First 1
Write-Host "Max power production $($maxProd.profit) $($maxProd.currency) ($($maxProd.production) $($maxProd.productionUnit) at $($maxProd.unitPrice)): $(([DateTime]$maxProd.from).ToString('HH:mm')) - $(([DateTime]$maxProd.to).ToString('HH:mm on yyyy-MM-dd'))"

### EXAMPLE 2

Get-TibberProduction -From ([DateTime]::Now).AddHours(-10)

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

### -Fields

Specifies the fields to return.

```yaml
Type: System.String[]
DefaultValue: >-
  @(
              'from'
              'to'
              'unitPrice'
              'unitPriceVAT'
              'production'
              'productionUnit'
              'profit'
              'currency'
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

### -FilterEmptyNodes

Switch to filter out empty nodes (i.e.
production is '0') from results.

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

### -From

Specifies the start date for nodes to include in results.

```yaml
Type: System.DateTime
DefaultValue: ''
SupportsWildcards: false
Aliases:
- After
- Start
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

### -Last

Specifies the number of nodes to include in results, counting from the latest entry.

```yaml
Type: System.Int32
DefaultValue: 1
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

### -Resolution

Specifies the resoluton of the results.

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

### -To

Specifies the end date for nodes to include in results.
Providing a date only, e.g.
'2023-10-31', will set the time to 23:59:59.

```yaml
Type: System.DateTime
DefaultValue: '[DateTime]::Now'
SupportsWildcards: false
Aliases:
- End
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

### System.DateTime

{{ Fill in the Description }}

### System.Int32

{{ Fill in the Description }}

### System.String[]

{{ Fill in the Description }}

## OUTPUTS

## NOTES

## RELATED LINKS

- [Invoke-TibberQuery](Invoke-TibberQuery.md)
- [](https://developer.tibber.com/docs/reference#production)
