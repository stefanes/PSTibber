---
document type: cmdlet
external help file: PSTibber-Help.xml
HelpUri: https://developer.tibber.com/docs/reference#livemeasurement
Locale: sv-SE
Module Name: PSTibber
ms.date: 09-19-2025
PlatyPS schema version: 2024-05-01
title: Register-TibberLiveMeasurementSubscription
---

# Register-TibberLiveMeasurementSubscription

## SYNOPSIS

Create new GraphQL subscription to the live measurement API.

## SYNTAX

### __AllParameterSets

```
Register-TibberLiveMeasurementSubscription [-Connection] <Object> [[-Fields] <string[]>]
 [[-TimeoutInSeconds] <int>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Calling this function will return a subscription object for the created subscription.
The object returned is intended to be used with other functions for managing the subscription.

## EXAMPLES

### EXAMPLE 1

$subscription = Register-TibberLiveMeasurementSubscription -Connection $connection -HomeId '96a14971-525a-4420-aae9-e5aedaa129ff'
Write-Host "New GraphQL subscription created: $($subscription.Id)"

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

### -Fields

Specifies the fields to return.

```yaml
Type: System.String[]
DefaultValue: >-
  @(
              'timestamp'
              'power'
              'powerReactive'
              'powerProduction'
              'powerProductionReactive'
              'accumulatedConsumption'
              'accumulatedConsumptionLastHour'
              'accumulatedProduction'
              'accumulatedProductionLastHour'
              'accumulatedCost'
              'accumulatedReward'
              'currency'
              'minPower'
              'averagePower'
              'maxPower'
              'minPowerProduction'
              'maxPowerProduction'
              'voltagePhase1'
              'voltagePhase2'
              'voltagePhase3'
              'currentL1'
              'currentL2'
              'currentL3'
              'lastMeterConsumption'
              'lastMeterProduction'
              'powerFactor'
              'signalStrength'
          )
SupportsWildcards: false
Aliases: []
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

{{ Fill in the Description }}

### System.String[]

{{ Fill in the Description }}

### System.Int32

{{ Fill in the Description }}

## OUTPUTS

## NOTES

## RELATED LINKS

- [Connect-TibberWebSocket](Connect-TibberWebSocket.md)
- [](https://developer.tibber.com/docs/reference#livemeasurement)
