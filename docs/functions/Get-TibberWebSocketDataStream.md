# Get-TibberWebSocketDataStream

## SYNOPSIS
Read GraphQL data stream over the provided WebSocket connection.

## SYNTAX

```
Get-TibberWebSocketDataStream [-Connection] <Object> [-Callback] <ScriptBlock> [<CommonParameters>]
```

## DESCRIPTION
Calling this function will read GraphQL data stream over the provided WebSocket connection.

## EXAMPLES

### EXAMPLE 1
```
Get-TibberWebSocketData -Connection $connection
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

### -Callback
Specifies the script block called for each response.

```yaml
Type: ScriptBlock
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

[Connect-TibberWebSocket](Connect-TibberWebSocket.md)

[https://developer.tibber.com/docs/reference#livemeasurement](https://developer.tibber.com/docs/reference#livemeasurement)

