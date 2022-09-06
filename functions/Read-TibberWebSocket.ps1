function Read-TibberWebSocket {
    <#
    .Synopsis
        Read packages on the provided WebSocket connection.
    .Description
        Calling this function will read packages on the provided WebSocket connection.
    .Example
        Read-TibberWebSocket -Connection $connection -Callback { param($package)
            Write-Host "New package on WebSocket connection: $package"
        }
    .Example
        function Write-PackageToHost {
            param (
                [string] $package
            )
            Write-Host "New package on WebSocket connection: $data"
        }
        Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost}
    .Example
        $result = Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -TimeoutInSeconds 30
        Write-Host "Read $($result.NumberOfPackages) packages in $($result.ElapsedTimeInSeconds) seconds"
    .Example
        Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -Count 3
        Write-Host "Read $($result.NumberOfPackages) packages in $($result.ElapsedTimeInSeconds) seconds"
    .Link
        Connect-TibberWebSocket
    .Link
        https://developer.tibber.com/docs/reference#livemeasurement
    #>
    param (
        # Specifies the connection to use for the communication.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Object] $Connection,

        # Specifies the script block called for each response.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [ScriptBlock] $Callback,

        # Specifies the time in seconds to to read data, or -1 to read indefinitely.
        [Parameter(ValueFromPipelineByPropertyName)]
        [int] $TimeoutInSeconds = -1,

        # Specifies the number of responses to read, or -1 to read indefinitely.
        [Parameter(ValueFromPipelineByPropertyName)]
        [int] $Count = -1
    )

    begin {
        # Setup parameters
        $uri = $Connection.URI
        $webSocket = $Connection.WebSocket
        $cancellationToken = $Connection.CancellationTokenSource.Token
        $recvBuffer = $Connection.RecvBuffer
    }

    process {
        Write-Verbose "Read packages from $URI"

        # Reading packages
        $timer = [Diagnostics.Stopwatch]::StartNew()
        $counter = 0
        while (($timer.Elapsed.TotalSeconds -lt $TimeoutInSeconds -Or $TimeoutInSeconds -lt 0) `
                -And ($counter++ -lt $Count -Or $Count -lt 0) `
                -And ($webSocket.State -eq 'Open')) {
            $response = ""
            do {
                $result = $webSocket.ReceiveAsync($recvBuffer, $cancellationToken)
                while (-Not $result.IsCompleted) {
                    Start-Sleep -Milliseconds 10
                }
                Write-Debug -Message "WebSocket status:"
                Write-Debug -Message ($webSocket | Select-Object * | Out-String)
                Write-Debug -Message "WebSocket operation result:"
                Write-Debug -Message ($result | Select-Object * | Out-String)

                $response += [Text.Encoding]::ASCII.GetString($recvBuffer.Array, 0, $result.Result.Count)
            } until ($result.Result.EndOfMessage)

            Invoke-Command -ScriptBlock $Callback -ArgumentList $response
        }

        $timer.Stop()
        Write-Verbose "Read $counter packages in $($timer.Elapsed.TotalSeconds) seconds"

        # Output result object
        @{
            NumberOfPackages     = $counter
            ElapsedTimeInSeconds = $timer.Elapsed.TotalSeconds
        }
    }
}
