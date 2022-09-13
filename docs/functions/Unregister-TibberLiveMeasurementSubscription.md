# Unregister-TibberLiveMeasurementSubscription

## SYNOPSIS
Stop the provided GraphQL subscription to the live measurement API.

## SYNTAX

```
Unregister-TibberLiveMeasurementSubscription [-Connection] <Object> [-Subscription] <Object>
 [[-TimeoutInSeconds] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Calling this function will stop the provided GraphQL subscription to the live measurement API.

## EXAMPLES

### EXAMPLE 1
```
Unregister-TibberLiveMeasurementSubscription -Connection $connection -Subscription $subscription
Write-Host "New GraphQL subscription with Id $($subscription.Id) stopped"
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

### -Subscription
Specifies the subscripton to manage.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
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

[Register-TibberLiveMeasurementSubscription](Register-TibberLiveMeasurementSubscription.md)

[https://developer.tibber.com/docs/reference#livemeasurement](https://developer.tibber.com/docs/reference#livemeasurement)

