# Disconnect-TibberWebSocket

## SYNOPSIS
Close a GraphQL over WebSocket connection.

## SYNTAX

```
Disconnect-TibberWebSocket [-Connection] <Object> [<CommonParameters>]
```

## DESCRIPTION
Calling this function will close an established WebSocket connection.

## EXAMPLES

### EXAMPLE 1
```
Disconnect-TibberWebSocket -Connection $connection
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Connect-TibberWebSocket](Connect-TibberWebSocket.md)

[https://developer.tibber.com/docs/guides/calling-api](https://developer.tibber.com/docs/guides/calling-api)

