function Read-TibberWebSocket {
    <#
    .Synopsis
        Read packages on the provided WebSocket connection.
    .Description
        Calling this function will read packages on the provided WebSocket connection.
    .Example
        Read-TibberWebSocket -Connection $connection -Callback { param($Json)
            Write-Host "New Json document received: $($Json.payload.data | Out-String)"
        }
    .Example
        function Write-PackageToHost {
            param (
                [Object] $Json
            )
            Write-Host "New Json document received: $($Json.payload.data | Out-String)"
        }
        Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost}
    .Example
        $result = Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -DurationInSeconds 30
        Write-Host "Read $($result.NumberOfPackages) package(s) in $($result.ElapsedTimeInSeconds) seconds"
    .Example
        Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -PackageCount 3
        Write-Host "Read $($result.NumberOfPackages) package(s) in $($result.ElapsedTimeInSeconds) seconds"
    .Example
        function Write-PackageToHost {
            param (
                [Object] $Json,
                [string] $With,
                [string] $Additional,
                [int] $Arguments
            )
            Write-Host "New Json document received: $($Json.payload.data | Out-String)"
            Write-Host "$With $Additional $Arguments"
        }
        Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -CallbackArgumentList @("Hello", "world!", 2022)
    .Link
        Register-TibberLiveMeasurementSubscription
    .Link
        https://developer.tibber.com/docs/reference#livemeasurement
    #>
    param (
        # Specifies the connection to use for the communication.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Object] $Connection,

        # Specifies the script block/function called for each response.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Alias('OnNext')]
        [ScriptBlock] $Callback,

        # Specifies the script block/function called after recieving a 'complete' message.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('OnCompleted')]
        [ScriptBlock] $CallbackComplete = $Callback,

        # Specifies the optional arguments passed on to the callback script block, positioned after the response.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('CallbackArguments', 'Arguments', 'Args')]
        [Object[]] $CallbackArgumentList = @(),

        # Specifies for how long in seconds we should read packages, or -1 to read indefinitely.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(-1, [int]::MaxValue)]
        [Alias('Duration')]
        [int] $DurationInSeconds = -1,

        # Specifies a date/time to read data until (a deadline).
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('Until', 'Deadline')]
        [DateTime] $ReadUntil = ([DateTime]::Now).AddSeconds(-1),

        # Specifies the number of packages to read, or -1 to read indefinitely.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(-1, [int]::MaxValue)]
        [Alias('Count')]
        [int] $PackageCount = -1,

        # Specifies the time to wait for WebSocket operations, or -1 to wait indefinitely.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(-1, [int]::MaxValue)]
        [Alias('Timeout')]
        [int] $TimeoutInSeconds = 30
    )

    begin {
        # Setup parameters
        $uri = $Connection.URI
        $webSocket = $Connection.WebSocket
        $cancellationToken = $Connection.CancellationTokenSource.Token
        $recvBuffer = $Connection.RecvBuffer
    }

    process {
        # Caluculate duration
        $duration = ($ReadUntil - ([DateTime]::Now)).TotalSeconds
        if ($duration -le -1 -Or ($DurationInSeconds -ne -1 -And $duration -gt $DurationInSeconds)) {
            $duration = $DurationInSeconds
        }

        Write-Verbose -Message "Read packages from $URI [Duration (s) = $duration | Package count = $PackageCount | Timeout (s) = $TimeoutInSeconds]"

        # Reading packages
        $timer = [Diagnostics.Stopwatch]::StartNew()
        $packageCounter = 0
        while (($duration -eq -1 -Or $timer.Elapsed.TotalSeconds -lt $duration) `
                -And ($PackageCount -eq -1 -Or $packageCounter -lt $PackageCount) `
                -And ($webSocket.State -eq 'Open')) {
            $response = Read-WebSocket -ReceiveBuffer $recvBuffer -WebSocket $webSocket -CancellationToken $cancellationToken -TimeoutInSeconds $TimeoutInSeconds
            $response = $response | ConvertFrom-Json
            $arguments = @(, $response) + $CallbackArgumentList
            switch ($response.Type) {
                'next' {
                    Invoke-Command -ScriptBlock $Callback -ArgumentList $arguments
                }
                'complete' {
                    Invoke-Command -ScriptBlock $CallbackComplete -ArgumentList $arguments
                }
                'error' {
                    throw "WebSocket error message received: $($response | ConvertTo-Json -Depth 10)"
                }
            }
            $packageCounter++
        }

        $timer.Stop()
        Write-Verbose -Message "Read $packageCounter package(s) in $($timer.Elapsed.TotalSeconds) seconds"

        # Output result object
        [PSCustomObject]@{
            NumberOfPackages     = $packageCounter
            ElapsedTimeInSeconds = $timer.Elapsed.TotalSeconds
        }
    }
}
