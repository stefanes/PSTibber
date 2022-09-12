function Read-WebSocket {
    <#
    .Synopsis
        Read data from WebSocket.
    .Description
        Calling this function will return the data read from WebSocket.
    .Link
        https://docs.microsoft.com/en-us/dotnet/api/system.net.websockets.clientwebsocket.receiveasync?view=net-6.0
    #>
    param (
        # Specifies the data to write to WebSocket.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('RecvBuffer')]
        [ArraySegment[byte]] $ReceiveBuffer,

        # Specifies the WebSocket to write to.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Net.WebSockets.ClientWebSocket] $WebSocket,

        # Specifies the cancellation token used to propagate notification that the operation should be canceled.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Threading.CancellationToken] $CancellationToken,

        # Specifies the time to wait for WebSocket operation, or -1 to wait indefinitely.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [ValidateRange(-1, [int]::MaxValue)]
        [Alias('Timeout')]
        [int] $TimeoutInSeconds,

        # Switch to ignore WebSocket operation errors.
        [Alias('Ignore')]
        [switch] $IgnoreError
    )

    process {
        # Setup recieve buffer if not provided.
        if (-Not $ReceiveBuffer) {
            $ReceiveBuffer = New-Object ArraySegment[byte] -ArgumentList @(, $([byte[]] @(, 0) * 16384))
        }

        Write-Verbose -Message "Read data from WebSocket [Timeout (s) = $TimeoutInSeconds | Ignore error = $($IgnoreError.IsPresent)]"

        # Read data from WebSocket
        $response = ""
        do {
            $result = $WebSocket.ReceiveAsync($ReceiveBuffer, $CancellationToken)
            Wait-WebSocketOp -OperationName 'ReceiveAsync' -Result $result -TimeoutInSeconds $TimeoutInSeconds -IgnoreError:$IgnoreError
            Write-Debug -Message "WebSocket status:"
            Write-Debug -Message ($WebSocket | Select-Object * | Out-String)
            $response += [Text.Encoding]::ASCII.GetString($ReceiveBuffer.Array, 0, $result.Result.Count)
        } until ($result.Result.EndOfMessage)
        Write-Debug -Message "Read data from WebSocket:"
        Write-Debug -Message $response

        # Output response
        $response
    }
}
