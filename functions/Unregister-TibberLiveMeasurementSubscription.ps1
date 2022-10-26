function Unregister-TibberLiveMeasurementSubscription {
    <#
    .Synopsis
        Stop the provided GraphQL subscription to the live measurement API.
    .Description
        Calling this function will stop the provided GraphQL subscription to the live measurement API.
    .Example
        Unregister-TibberLiveMeasurementSubscription -Connection $connection -Subscription $subscription
        Write-Host "New GraphQL subscription with Id $($subscription.Id) stopped"
    .Link
        Register-TibberLiveMeasurementSubscription
    .Link
        https://developer.tibber.com/docs/reference#livemeasurement
    #>
    [CmdletBinding(DefaultParameterSetName = 'URI')]
    [Alias('Unregister-TibberLiveConsumptionSubscription')]
    param (
        # Specifies the connection to use for the communication.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Object] $Connection,

        # Specifies the subscripton to manage.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Object] $Subscription,

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
        $cancellationToken = $Connection.CancellationTokenSource.Token
        $subscriptionId = $Subscription.Id
    }

    process {
        # Send request
        $command = @{
            id   = $subscriptionId
            type = 'stop'
        } | ConvertTo-Json -Depth 10
        Write-WebSocket -Data $command -WebSocket $webSocket -CancellationToken $cancellationToken -TimeoutInSeconds $TimeoutInSeconds
        Write-Verbose -Message "Unsubscribe request sent to: $uri [stop]"
    }
}
