---
document type: cmdlet
external help file: PSTibber-Help.xml
HelpUri: https://developer.tibber.com/docs/reference#viewer
Locale: sv-SE
Module Name: PSTibber
ms.date: 09-19-2025
PlatyPS schema version: 2024-05-01
title: Get-TibberUser
---

# Get-TibberUser

## SYNOPSIS

Get information about the logged-in user.

## SYNTAX

### __AllParameterSets

```
Get-TibberUser [[-Fields] <string[]>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Calling this function will return information about the logged-in user.

## EXAMPLES

### EXAMPLE 1

$response = Get-TibberUser -Fields 'login', 'userId', 'name'
Write-Host "$($response.name) <$($response.login)> with user Id $($response.userId)"

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
              'login'
              'userId'
              'name'
              'accountType'
              'websocketSubscriptionUrl'
          )
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
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

### System.String[]

{{ Fill in the Description }}

## OUTPUTS

## NOTES

## RELATED LINKS

- [Invoke-TibberQuery](Invoke-TibberQuery.md)
- [](https://developer.tibber.com/docs/reference#viewer)
