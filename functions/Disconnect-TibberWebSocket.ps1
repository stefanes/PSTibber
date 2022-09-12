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
        [Object] $Connection,

        # Specifies the time to wait for WebSocket operations, or -1 to wait indefinitely.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(-1, [int]::MaxValue)]
        [Alias('Timeout')]
        [int] $TimeoutInSeconds = 10
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
        Wait-WebSocketOp -OperationName 'CloseAsync' -Result $result -TimeoutInSeconds $TimeoutInSeconds
        Write-Debug -Message "WebSocket status:"
        Write-Debug -Message ($webSocket | Select-Object * | Out-String)
        Write-Verbose "Closed WebSocket connected to $uri"

        # Release used resources
        $webSocket.Dispose()
        $cancellationTokenSource.Dispose()
        Write-Verbose "Released used resources"
    }
}
