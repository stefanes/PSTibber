---
document type: cmdlet
external help file: PSTibber-Help.xml
HelpUri: https://developer.tibber.com/docs/guides/calling-api
Locale: sv-SE
Module Name: PSTibber
ms.date: 09-19-2025
PlatyPS schema version: 2024-05-01
title: Disconnect-TibberWebSocket
---

# Disconnect-TibberWebSocket

## SYNOPSIS

Close a GraphQL over WebSocket connection.

## SYNTAX

### __AllParameterSets

```
Disconnect-TibberWebSocket [-Connection] <Object> [[-TimeoutInSeconds] <int>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Calling this function will close an established WebSocket connection.

## EXAMPLES

### EXAMPLE 1

Disconnect-TibberWebSocket -Connection $connection

## PARAMETERS

### -Connection

Specifies the connection to use for the communication.

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
Aliases: []
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
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
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

### System.Object

{{ Fill in the Description }}

### System.Int32

{{ Fill in the Description }}

## OUTPUTS

## NOTES

## RELATED LINKS

- [Connect-TibberWebSocket](Connect-TibberWebSocket.md)
- [](https://developer.tibber.com/docs/guides/calling-api)
