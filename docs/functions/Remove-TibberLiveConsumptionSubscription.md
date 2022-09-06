# Remove-TibberLiveConsumptionSubscription

## SYNOPSIS
Stop the provided GraphQL subscription.

## SYNTAX

```
Remove-TibberLiveConsumptionSubscription [-Connection] <Object> [-Subscription] <Object> [<CommonParameters>]
```

## DESCRIPTION
Calling this function will stop the provided GraphQL subscription.

## EXAMPLES

### EXAMPLE 1
```
Remove-TibberLiveConsumptionSubscription -Connection $connection -Subscription $subscription
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-TibberLiveConsumptionSubscription](New-TibberLiveConsumptionSubscription.md)

[https://developer.tibber.com/docs/reference#livemeasurement](https://developer.tibber.com/docs/reference#livemeasurement)

