function Get-WebSockerConnectWaitTime {
    <#
    .Synopsis
        Get wait time.
    .Description
        Get time to wait in seconds between connection retries.
    .Link
        https://github.com/tibber/Tibber.SDK.NET/blob/9c0e4441d2c2860fcb646c593a1064fdd4c52e9f/src/Tibber.Sdk/RealTimeMeasurementListener.cs#L477
    #>
    param (
        # Specifies the time to wait for WebSocket operation, or -1 to wait indefinitely.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [ValidateRange(0, [int]::MaxValue)]
        [Alias('Retry', 'Attempt')]
        [int] $RetryAttempt
    )

    process {
        # Jitter of 5 to 60 seconds
        $jitter = Get-Random -Minimum 5 -Maximum 60
        Write-Verbose "Jitter: $jitter"

        # Exponential backoff (max one day)
        $delay = [Math]::Min([Math]::Pow($RetryAttempt, 2), 86400)
        Write-Verbose "Delay: $delay"

        # Total wait time
        $waitTime = $jitter + $delay
        Write-Verbose "Wait time: $waitTime"

        # Output wait time
        $waitTime
    }
}
