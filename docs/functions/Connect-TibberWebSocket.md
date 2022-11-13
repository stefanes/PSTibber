# Connect-TibberWebSocket

## SYNOPSIS
Create a new GraphQL over WebSocket connection.

## SYNTAX

```
Connect-TibberWebSocket [-HomeId] <String> [[-RetryCount] <Int32>] [[-TimeoutInSeconds] <Int32>] [-URI <Uri>]
 [-PersonalAccessToken <String>] [-UserAgent <String>] [-Force] [-DebugResponse] [<CommonParameters>]
```

## DESCRIPTION
Calling this function will return a connection object for the established WebSocket connection.
The object returned is intended to be used with other functions for communication with the endpoint.

## EXAMPLES

### EXAMPLE 1
```
$connection = Connect-TibberWebSocket
Write-Host "New connection created: $($connection.WebSocket.State)"
```

## PARAMETERS

### -HomeId
Specifies the home Id, e.g.
'96a14971-525a-4420-aae9-e5aedaa129ff'.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RetryCount
Specifies the number of retry attempts if WebSocket initialization fails.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Retries, MaxRetries

Required: False
Position: 2
Default value: 5
Accept pipeline input: False
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

### -DebugResponse
{{ Fill DebugResponse Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
{{ Fill Force Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersonalAccessToken
{{ Fill PersonalAccessToken Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: PAT, AccessToken, Token

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -URI
{{ Fill URI Description }}

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: URL

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserAgent
{{ Fill UserAgent Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://docs.microsoft.com/en-us/dotnet/api/system.net.websockets.clientwebsocket](https://docs.microsoft.com/en-us/dotnet/api/system.net.websockets.clientwebsocket)

[https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md](https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md)

[https://developer.tibber.com/docs/guides/calling-api](https://developer.tibber.com/docs/guides/calling-api)

