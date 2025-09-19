---
document type: cmdlet
external help file: PSTibber-Help.xml
HelpUri: https://developer.tibber.com/docs/reference#pushnotificationinput
Locale: sv-SE
Module Name: PSTibber
ms.date: 09-19-2025
PlatyPS schema version: 2024-05-01
title: Send-PushNotification
---

# Send-PushNotification

## SYNOPSIS

Send push notifications to the Tibber app on registered devices.

## SYNTAX

### __AllParameterSets

```
Send-PushNotification [[-Title] <string>] [-Message] <string> [[-ScreenToOpen] <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Calling this function will send push notifications to the Tibber app on registered devices.

## EXAMPLES

### EXAMPLE 1

Send-PushNotification -Title 'Hello' -Message 'World!' -ScreenToOpen CONSUMPTION

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

### -Message

Specifies the body of the push notification.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Body
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
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

### -ScreenToOpen

Specifies the app screent to open.
https://developer.tibber.com/docs/reference#appscreen

```yaml
Type: System.String
DefaultValue: HOME
SupportsWildcards: false
Aliases:
- AppScreen
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Title

Specifies the title of the push notification.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Subject
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

## OUTPUTS

## NOTES

## RELATED LINKS

- [Invoke-TibberQuery](Invoke-TibberQuery.md)
- [](https://developer.tibber.com/docs/reference#pushnotificationinput)
