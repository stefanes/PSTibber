---
document type: cmdlet
external help file: PSTibber-Help.xml
HelpUri: https://developer.tibber.com/docs/reference#livemeasurement
Locale: sv-SE
Module Name: PSTibber
ms.date: 09-19-2025
PlatyPS schema version: 2024-05-01
title: Read-TibberWebSocket
---

# Read-TibberWebSocket

## SYNOPSIS

Read packages on the provided WebSocket connection.

## SYNTAX

### __AllParameterSets

```
Read-TibberWebSocket [-Connection] <Object> [-Callback] <scriptblock>
 [[-CallbackComplete] <scriptblock>] [[-CallbackError] <scriptblock>]
 [[-CallbackArgumentList] <Object[]>] [[-DurationInSeconds] <int>] [[-ReadUntil] <datetime>]
 [[-PackageCount] <int>] [[-TimeoutInSeconds] <int>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Calling this function will read packages on the provided WebSocket connection.

## EXAMPLES

### EXAMPLE 1

Read-TibberWebSocket -Connection $connection -Callback { param($Json)
    Write-Host "New Json document received: $($Json.payload.data | Out-String)"
}

### EXAMPLE 2

function Write-PackageToHost {
    param (
        [Object] $Json
    )
    Write-Host "New Json document received: $($Json.payload.data | Out-String)"
}
Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost}

### EXAMPLE 3

$result = Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -DurationInSeconds 30
Write-Host "Read $($result.NumberOfPackages) package(s) in $($result.ElapsedTimeInSeconds) seconds"

### EXAMPLE 4

Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -PackageCount 3
Write-Host "Read $($result.NumberOfPackages) package(s) in $($result.ElapsedTimeInSeconds) seconds"

### EXAMPLE 5

function Write-PackageToHost {
    param (
        [Object] $Json,
        [string] $With,
        [string] $Additional,
        [int] $Arguments
    )
    Write-Host "New Json document received: $($Json.payload.data | Out-String)"
    Write-Host "$With $Additional $Arguments"
}
Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -CallbackArgumentList @("Hello", "world!", 2022)

## PARAMETERS

### -Callback

Specifies the default script block/function called for each response.

```yaml
Type: System.Management.Automation.ScriptBlock
DefaultValue: ''
SupportsWildcards: false
Aliases:
- OnNext
- CallbackNext
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

### -CallbackArgumentList

Specifies the optional arguments passed on to the callback script block, positioned after the response.

```yaml
Type: System.Object[]
DefaultValue: '@()'
SupportsWildcards: false
Aliases:
- CallbackArguments
- Arguments
- Args
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -CallbackComplete

Specifies the script block/function called after recieving a 'complete' message.

```yaml
Type: System.Management.Automation.ScriptBlock
DefaultValue: $Callback
SupportsWildcards: false
Aliases:
- OnComplete
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

### -CallbackError

Specifies the script block/function called after recieving a 'error' message.

```yaml
Type: System.Management.Automation.ScriptBlock
DefaultValue: >-
  {
              throw "WebSocket error message received: $($response | ConvertTo-Json -Depth 10)"
          }
SupportsWildcards: false
Aliases:
- OnError
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

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

### -DurationInSeconds

Specifies for how long in seconds we should read packages, or -1 to read indefinitely.

```yaml
Type: System.Int32
DefaultValue: -1
SupportsWildcards: false
Aliases:
- Duration
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PackageCount

Specifies the number of packages to read, or -1 to read indefinitely.

```yaml
Type: System.Int32
DefaultValue: -1
SupportsWildcards: false
Aliases:
- Count
ParameterSets:
- Name: (All)
  Position: 7
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ReadUntil

Specifies a date/time to read data until (a deadline).

```yaml
Type: System.DateTime
DefaultValue: ([DateTime]::Now).AddSeconds(-1)
SupportsWildcards: false
Aliases:
- Until
- Deadline
ParameterSets:
- Name: (All)
  Position: 6
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
DefaultValue: 30
SupportsWildcards: false
Aliases:
- Timeout
ParameterSets:
- Name: (All)
  Position: 8
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

### System.Management.Automation.ScriptBlock

{{ Fill in the Description }}

### System.Object[]

{{ Fill in the Description }}

### System.Int32

{{ Fill in the Description }}

### System.DateTime

{{ Fill in the Description }}

## OUTPUTS

## NOTES

## RELATED LINKS

- [Register-TibberLiveMeasurementSubscription](Register-TibberLiveMeasurementSubscription.md)
- [](https://developer.tibber.com/docs/reference#livemeasurement)
