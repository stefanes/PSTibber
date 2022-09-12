function Write-WebSocket {
    <#
    .Synopsis
        Write data to WebSocket.
    .Description
        Calling this function will write data to WebSocket, returning the resulting 'Threading.Tasks.Task' object.
    .Link
        https://docs.microsoft.com/en-us/dotnet/api/system.net.websockets.clientwebsocket.receiveasync?view=net-6.0
    #>
    param (
        # Specifies the data to write to WebSocket.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Alias('Command')]
        [string] $Data,

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
        Write-Verbose -Message "Write data to WebSocket [Timeout (s) = $TimeoutInSeconds | Ignore error = $($IgnoreError.IsPresent)]"

        # Write data to WebSocket
        Write-Debug -Message "Writing data to WebSocket:"
        Write-Debug -Message $Data
        $sendData = New-Object ArraySegment[byte] -ArgumentList @(, $([Text.Encoding]::ASCII.GetBytes($Data)))
        $result = $WebSocket.SendAsync($sendData, [Net.WebSockets.WebSocketMessageType]::Text, $true, $CancellationToken)
        Wait-WebSocketOp -OperationName 'SendAsync' -Result $result -TimeoutInSeconds $TimeoutInSeconds -IgnoreError:$IgnoreError
        Write-Debug -Message "WebSocket status:"
        Write-Debug -Message ($WebSocket | Select-Object * | Out-String)
    }
}
