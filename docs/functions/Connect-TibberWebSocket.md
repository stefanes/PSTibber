# Connect-TibberWebSocket

## SYNOPSIS
Create a new GraphQL over WebSocket connection.

## SYNTAX

```
Connect-TibberWebSocket [[-PersonalAccessToken] <String>] [[-RetryCount] <Int32>] [[-TimeoutInSeconds] <Int32>]
 [[-UserAgent] <String>] [<CommonParameters>]
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

### -PersonalAccessToken
Specifies the access token to use for the communication.
Override default using the TIBBER_ACCESS_TOKEN environment variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PAT, AccessToken, Token

Required: False
Position: 1
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

### -UserAgent
Specifies the user agent (appended to the default).
Override default using the TIBBER_USER_AGENT environment variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: $(
            if ($env:TIBBER_USER_AGENT) {
                $env:TIBBER_USER_AGENT
            }
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

[https://docs.microsoft.com/en-us/dotnet/api/system.net.websockets.clientwebsocket](https://docs.microsoft.com/en-us/dotnet/api/system.net.websockets.clientwebsocket)

[https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md](https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md)

[https://developer.tibber.com/docs/guides/calling-api](https://developer.tibber.com/docs/guides/calling-api)

