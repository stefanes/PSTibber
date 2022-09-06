function Connect-TibberWebSocket {
    <#
    .Synopsis
        Create a new GraphQL over WebSocket connection.
    .Description
        Calling this function will return a connection object for the established WebSocket connection.
        The object returned is intended to be used with other functions for communication with the endpoint.
    .Example
        $connection = Connect-TibberWebSocket
        Write-Host "New connection created: $($connection.WebSocket.State)"
    .Link
        Net.WebSockets.ClientWebSocket
    .Link
        https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md
    .Link
        https://developer.tibber.com/docs/guides/calling-api
    #>
    param (
        # Specifies the URI for the request.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('URL')]
        [Uri] $URI = 'wss://api.tibber.com/v1-beta/gql/subscriptions',

        # Specifies the access token to use for the communication.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('PAT', 'AccessToken', 'Token')]
        [string] $PersonalAccessToken = $(
            if ($script:TibberAccessTokenCache) {
                $script:TibberAccessTokenCache
            }
            elseif ($env:TIBBER_ACCESS_TOKEN) {
                $env:TIBBER_ACCESS_TOKEN
            }
            else {
                '5K4MVS-OjfWhK_4yrjOlFe1F6kJXPVf7eQYggo8ebAE' # demo token
            }
        )
    )

    begin {
        # Setup WebSocket for communication
        $webSocket = New-Object Net.WebSockets.ClientWebSocket
        $webSocket.Options.AddSubProtocol('graphql-transport-ws')
        $cancellationTokenSource = New-Object Threading.CancellationTokenSource
        $cancellationToken = $cancellationTokenSource.Token
        $recvBuffer = New-Object ArraySegment[byte] -ArgumentList @(, $([byte[]] @(, 0) * 16384))
    }

    process {
        # Connect WebSocket
        $result = $webSocket.ConnectAsync($URI, $cancellationToken)
        while (-Not $result.IsCompleted) {
            Start-Sleep -Milliseconds 10
        }
        Write-Verbose "WebSocket connected to $URI"

        # Init WebSocket
        $command = @{
            type    = 'connection_init'
            payload = @{
                token = $PersonalAccessToken
            }
        } | ConvertTo-Json -Depth 10
        Write-Debug -Message ("Invoking GraphQL over WebSocket command: " + $URI)
        Write-Debug -Message "GraphQL over WebSocket command:"
        Write-Debug -Message $command
        $sendCommand = New-Object ArraySegment[byte] -ArgumentList @(, $([Text.Encoding]::ASCII.GetBytes($command)))
        $result = $webSocket.SendAsync($sendCommand, [Net.WebSockets.WebSocketMessageType]::Text, $true, $cancellationToken)
        while (-Not $result.IsCompleted) {
            Start-Sleep -Milliseconds 10
        }
        Write-Debug -Message "WebSocket status:"
        Write-Debug -Message ($webSocket | Select-Object * | Out-String)
        Write-Debug -Message "WebSocket operation result:"
        Write-Debug -Message ($result | Select-Object * | Out-String)
        if ($result.Result.CloseStatus) {
            Write-Error "Send failed: $($result.Result.CloseStatusDescription) [$($result.Result.CloseStatus)]"
            return $null
        }
        Write-Verbose "Init message sent"

        # WebSocket init acknowledgement
        $result = $webSocket.ReceiveAsync($recvBuffer, $cancellationToken)
        while (-Not $result.IsCompleted) {
            Start-Sleep -Milliseconds 10
        }
        Write-Debug -Message "WebSocket status:"
        Write-Debug -Message ($webSocket | Select-Object * | Out-String)
        Write-Debug -Message "WebSocket operation result:"
        Write-Debug -Message ($result | Select-Object * | Out-String)
        if ($result.Result.CloseStatus) {
            Write-Error "Receive failed: $($result.Result.CloseStatusDescription) [$($result.Result.CloseStatus)]"
            return $null
        }
        $response = [Text.Encoding]::ASCII.GetString($recvBuffer.Array, 0, $result.Result.Count)
        Write-Verbose "Init response: $response"

        # Output connection object
        @{
            URI                     = $URI
            WebSocket               = $webSocket
            CancellationTokenSource = $cancellationTokenSource
            RecvBuffer              = $recvBuffer
        }
    }
}
