# Register-TibberLiveConsumptionSubscription

## SYNOPSIS
Create new GraphQL subscription to the live consumption API.

## SYNTAX

```
Register-TibberLiveConsumptionSubscription [-Connection] <Object> [-HomeId] <String> [[-Fields] <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION
Calling this function will return a subscription object for the created subscription.
The object returned is intended to be used with other functions for managing the subscription.

## EXAMPLES

### EXAMPLE 1
```
$subscription = Register-TibberLiveConsumptionSubscription -Connection $connection -HomeId '96a14971-525a-4420-aae9-e5aedaa129ff'
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

### -HomeId
Specifies the home Id, e.g.
'96a14971-525a-4420-aae9-e5aedaa129ff'.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: 2
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
Position: 3
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Connect-TibberWebSocket](Connect-TibberWebSocket.md)

[https://developer.tibber.com/docs/reference#livemeasurement](https://developer.tibber.com/docs/reference#livemeasurement)
