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
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('Operation', 'Name')]
        [string] $OperationName = 'WebSocket operation',

        # Specifies the WebSocket operation result to wait for.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Threading.Tasks.Task] $Result,

        # Specifies the interval to use when polling for the WebSocket operation result.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(10, [int]::MaxValue)]
        [Alias('WaitTimeInMillis', 'WaitTimeMillis', 'WaitTime')]
        [int] $WaitTimeInMilliseconds = 300,

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
        Write-Verbose -Message "Wait for WebSocket operation to complete [Operation = $OperationName | Wait time (ms) = $WaitTimeInMilliseconds | Timeout (s) = $TimeoutInSeconds | Ignore error = $($IgnoreError.IsPresent)]"

        # Wait for operation to complete
        $timer = [Diagnostics.Stopwatch]::StartNew()
        while (-Not $Result.IsCompleted `
                -And ($TimeoutInSeconds -eq -1 -Or $timer.Elapsed.TotalSeconds -lt $TimeoutInSeconds)) {
            Start-Sleep -Milliseconds $WaitTimeInMilliseconds
        }
        $timer.Stop()
        if ($TimeoutInSeconds -ne -1 -And $timer.Elapsed.TotalSeconds -gt $TimeoutInSeconds) {
            throw "Timeout during $OperationName after $($timer.Elapsed.TotalSeconds) seconds"
        }
        Write-Debug -Message "$OperationName result:"
        Write-Debug -Message ($Result | Select-Object * | Out-String)
        Write-Debug -Message ($Result.Result | Select-Object * | Out-String)

        # Check for errors
        $errorMessage = ''
        if ($Result.Result.CloseStatus -Or $Result.Exception) {
            $errorMessage = "$OperationName failed: "
            if ($result.Result.CloseStatus) {
                $errorMessage += "$($result.Result.CloseStatusDescription) [$($result.Result.CloseStatus)]"
            } else {
                $errorMessage += "N/A [N/A]"
            }
            $errorMessage += "$([Environment]::NewLine)Exception: $($result.Exception)"
        }
        if ($errorMessage -ne '') {
            if ($IgnoreError.IsPresent) {
                Write-Verbose -Message $errorMessage
            } else {
                throw $errorMessage
            }
        }
    }
}
