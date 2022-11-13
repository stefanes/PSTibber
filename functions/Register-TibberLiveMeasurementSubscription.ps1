function Register-TibberLiveMeasurementSubscription {
    <#
    .Synopsis
        Create new GraphQL subscription to the live measurement API.
    .Description
        Calling this function will return a subscription object for the created subscription.
        The object returned is intended to be used with other functions for managing the subscription.
    .Example
        $subscription = Register-TibberLiveMeasurementSubscription -Connection $connection -HomeId '96a14971-525a-4420-aae9-e5aedaa129ff'
        Write-Host "New GraphQL subscription created: $($subscription.Id)"
    .Link
        Connect-TibberWebSocket
    .Link
        https://developer.tibber.com/docs/reference#livemeasurement
    #>
    [Alias('Register-TibberLiveConsumptionSubscription')]
    param (
        # Specifies the connection to use for the communication.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Object] $Connection,

        # Specifies the fields to return.
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]] $Fields = @(
            'timestamp'
            'power'
            'powerReactive'
            'powerProduction'
            'powerProductionReactive'
            'accumulatedConsumption'
            'accumulatedConsumptionLastHour'
            'accumulatedProduction'
            'accumulatedProductionLastHour'
            'accumulatedCost'
            'accumulatedReward'
            'currency'
            'minPower'
            'averagePower'
            'maxPower'
            'minPowerProduction'
            'maxPowerProduction'
            'voltagePhase1'
            'voltagePhase2'
            'voltagePhase3'
            'currentL1'
            'currentL2'
            'currentL3'
            'lastMeterConsumption'
            'lastMeterProduction'
            'powerFactor'
            'signalStrength'
        ),

        # Specifies the time to wait for WebSocket operations, or -1 to wait indefinitely.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(-1, [int]::MaxValue)]
        [Alias('Timeout')]
        [int] $TimeoutInSeconds = 10
    )

    begin {
        # Setup parameters
        $homeId = $Connection.HomeId
        $uri = $Connection.URI
        $webSocket = $Connection.WebSocket
        $cancellationToken = $Connection.CancellationTokenSource.Token
    }

    process {
        # Send request
        $subscriptionId = (New-Guid).Guid
        $command = @{
            id      = $subscriptionId
            type    = 'subscribe'
            payload = @{
                query = "subscription{ liveMeasurement(homeId:`"$homeId`"){ $($Fields -join ','),__typename }}"
            }
        } | ConvertTo-Json -Depth 10
        Write-WebSocket -Data $command -WebSocket $webSocket -CancellationToken $cancellationToken -TimeoutInSeconds $TimeoutInSeconds
        Write-Verbose -Message "Subscribe request sent to: $uri [subscribe]"

        # Output subscription object
        [PSCustomObject]@{
            Id = $subscriptionId
        }
    }
}
