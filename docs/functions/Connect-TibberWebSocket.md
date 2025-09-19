---
document type: cmdlet
external help file: PSTibber-Help.xml
HelpUri: https://docs.microsoft.com/en-us/dotnet/api/system.net.websockets.clientwebsocket
Locale: sv-SE
Module Name: PSTibber
ms.date: 09-19-2025
PlatyPS schema version: 2024-05-01
title: Connect-TibberWebSocket
---

# Connect-TibberWebSocket

## SYNOPSIS

Create a new GraphQL over WebSocket connection.

## SYNTAX

### __AllParameterSets

```
Connect-TibberWebSocket [-HomeId] <string> [[-RetryCount] <int>] [[-TimeoutInSeconds] <int>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Calling this function will return a connection object for the established WebSocket connection.
The object returned is intended to be used with other functions for communication with the endpoint.

## EXAMPLES

### EXAMPLE 1

$connection = Connect-TibberWebSocket
Write-Host "New connection created: $($connection.WebSocket.State)"

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
- Name: (All)
  Position: 0
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

### -RetryCount

Specifies the number of retry attempts if WebSocket initialization fails.

```yaml
Type: System.Int32
DefaultValue: 5
SupportsWildcards: false
Aliases:
- Retries
- MaxRetries
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TimeoutInSeconds

Specifies the time to wait for WebSocket operations, or -1 to wait indefinitely.

```yaml
Type: System.Int32
DefaultValue: 10
SupportsWildcards: false
Aliases:
- Timeout
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

## OUTPUTS

## NOTES

## RELATED LINKS

- [](https://docs.microsoft.com/en-us/dotnet/api/system.net.websockets.clientwebsocket)
- [](https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md)
- [](https://developer.tibber.com/docs/guides/calling-api)
