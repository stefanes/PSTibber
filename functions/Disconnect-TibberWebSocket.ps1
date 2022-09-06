function Disconnect-TibberWebSocket {
    <#
    .Synopsis
        Close a GraphQL over WebSocket connection.
    .Description
        Calling this function will close an established WebSocket connection.
    .Example
        Disconnect-TibberWebSocket -Connection $connection
    .Link
        Connect-TibberWebSocket
    .Link
        https://developer.tibber.com/docs/guides/calling-api
    #>
    param (
        # Specifies the connection to use for the communication.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Object] $Connection
    )

    begin {
        # Setup parameters
        $uri = $Connection.URI
        $webSocket = $Connection.WebSocket
        $cancellationTokenSource = $Connection.CancellationTokenSource
        $cancellationToken = $cancellationTokenSource.Token
    }

    process {
        # Close WebSocket
        $result = $webSocket.CloseAsync([Net.WebSockets.WebSocketCloseStatus]::NormalClosure, 'Connection closed by client', $cancellationToken)
        while (-Not $result.IsCompleted) {
            Start-Sleep -Milliseconds 10
        }
        Write-Debug -Message "WebSocket status:"
        Write-Debug -Message ($webSocket | Select-Object * | Out-String)
        Write-Debug -Message "WebSocket operation result:"
        Write-Debug -Message ($result | Select-Object * | Out-String)
        Write-Verbose "Closed WebSocket connected to $uri"

        # Release used resources
        $webSocket.Dispose()
        $cancellationTokenSource.Dispose()
        Write-Verbose "Released used resources"
    }
}
