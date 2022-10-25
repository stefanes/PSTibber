# Connect-TibberWebSocket

## SYNOPSIS
Create a new GraphQL over WebSocket connection.

## SYNTAX

```
Connect-TibberWebSocket [[-URI] <Uri>] [[-PersonalAccessToken] <String>] [[-RetryCount] <Int32>]
 [[-RetryWaitTimeInSeconds] <Int32>] [[-TimeoutInSeconds] <Int32>] [<CommonParameters>]
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

### -URI
Specifies the URI for the request.
Override default using the TIBBER_WSS_URI environment variable.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: URL

Required: False
Position: 1
Default value: $(
            if ($env:TIBBER_WSS_URI) {
                $env:TIBBER_WSS_URI
            }
            else {
                'wss://websocket-api.tibber.com/v1-beta/gql/subscriptions'
            }
        )
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PersonalAccessToken
Specifies the access token to use for the communication.
Override default using the TIBBER_ACCESS_TOKEN environment variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PAT, AccessToken, Token

Required: False
Position: 2
Default value: $(
            if ($script:TibberAccessTokenCache) {
                $script:TibberAccessTokenCache
            }
            elseif ($env:TIBBER_ACCESS_TOKEN) {
                $env:TIBBER_ACCESS_TOKEN
            }
        )
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RetryCount
Specifies the number of retry attempts if WebSocket initialization fails.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Retries

Required: False
Position: 3
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetryWaitTimeInSeconds
Specifies for how long in seconds we should wait between retries.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: RetryWaitTime, WaitTime

Required: False
Position: 4
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
Position: 5
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

[https://docs.microsoft.com/en-us/dotnet/api/system.net.websockets.clientwebsocket](https://docs.microsoft.com/en-us/dotnet/api/system.net.websockets.clientwebsocket)

[https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md](https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md)

[https://developer.tibber.com/docs/guides/calling-api](https://developer.tibber.com/docs/guides/calling-api)

