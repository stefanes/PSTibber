# Register-TibberLiveMeasurementSubscription

## SYNOPSIS
Create new GraphQL subscription to the live measurement API.

## SYNTAX

```
Register-TibberLiveMeasurementSubscription [-Connection] <Object> [[-Fields] <String[]>]
 [[-TimeoutInSeconds] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Calling this function will return a subscription object for the created subscription.
The object returned is intended to be used with other functions for managing the subscription.

## EXAMPLES

### EXAMPLE 1
```
$subscription = Register-TibberLiveMeasurementSubscription -Connection $connection -HomeId '96a14971-525a-4420-aae9-e5aedaa129ff'
Write-Host "New GraphQL subscription created: $($subscription.Id)"
```

## PARAMETERS

### -Connection
Specifies the connection to use for the communication.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
Position: 2
Default value: @(
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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TimeoutInSeconds
Specifies the time to wait for WebSocket operations, or -1 to wait indefinitely.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Timeout

Required: False
Position: 3
Default value: 10
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Connect-TibberWebSocket](Connect-TibberWebSocket.md)

[https://developer.tibber.com/docs/reference#livemeasurement](https://developer.tibber.com/docs/reference#livemeasurement)

