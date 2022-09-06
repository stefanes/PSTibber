# Read-TibberWebSocket

## SYNOPSIS
Read GraphQL data stream over the provided WebSocket connection.

## SYNTAX

```
Read-TibberWebSocket [-Connection] <Object> [-Callback] <ScriptBlock> [-TimeoutInSeconds] <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Calling this function will read GraphQL data stream over the provided WebSocket connection.

## EXAMPLES

### EXAMPLE 1
```
Read-TibberWebSocket -Connection $connection -Callback { param($data)
    Write-Host "Data read from stream: $data"
}
```

### EXAMPLE 2
```
function Write-DataToHost {
    param (
        [string] $data
    )
    Write-Host "Data read from stream: $data"
}
Read-TibberWebSocket -Connection $connection -Callback ${function:Write-DataToHost}
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

### -TimeoutInSeconds
{{ Fill TimeoutInSeconds Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
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

