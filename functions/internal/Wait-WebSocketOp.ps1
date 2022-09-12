function Wait-WebSocketOp {
    <#
    .Synopsis
        Wait for WebSocket operation to complete.
    .Description
        Calling this function will block waiting for a WebSocket operation to complete.
    .Link
        https://docs.microsoft.com/en-us/dotnet/api/system.net.websockets.clientwebsocket
    #>
    param (
        # Specifies the name of the WebSocket operation (for logging).
        [Alias('Operation', 'Name')]
        [string] $OperationName = 'WebSocket operation',

        # Specifies the WebSocket operation result to wait for.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Threading.Tasks.Task] $Result,

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
        $timer = [Diagnostics.Stopwatch]::StartNew()
        while (-Not $Result.IsCompleted `
                -And ($TimeoutInSeconds -eq -1 -Or $timer.Elapsed.TotalSeconds -lt $TimeoutInSeconds)) {
            Start-Sleep -Milliseconds 10
        }

        $timer.Stop()
        if ($TimeoutInSeconds -ne -1 -And $timer.Elapsed.TotalSeconds -gt $TimeoutInSeconds) {
            throw "Timeout during $OperationName after $($timer.Elapsed.TotalSeconds) seconds"
        }

        Write-Debug -Message "$OperationName result:"
        Write-Debug -Message ($Result | Select-Object * | Out-String)
        if ($Result.Result.CloseStatus) {
            $errorMessage = "$OperationName failed: $($result.Result.CloseStatusDescription) [$($result.Result.CloseStatus)]"
            if ($IgnoreError.IsPresent) {
                Write-Verbose $errorMessage
            }
            else {
                throw $errorMessage
            }
        }
    }
}
