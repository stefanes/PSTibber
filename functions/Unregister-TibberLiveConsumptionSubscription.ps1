function Unregister-TibberLiveConsumptionSubscription {
    <#
    .Synopsis
        Stop the provided GraphQL subscription.
    .Description
        Calling this function will stop the provided GraphQL subscription.
    .Example
        Unregister-TibberLiveConsumptionSubscription -Connection $connection -Subscription $subscription
        Write-Host "New GraphQL subscription with Id $($subscription.Id) stopped"
    .Link
        Register-TibberLiveConsumptionSubscription
    .Link
        https://developer.tibber.com/docs/reference#livemeasurement
    #>
    [CmdletBinding(DefaultParameterSetName = 'URI')]
    param (
        # Specifies the connection to use for the communication.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Object] $Connection,

        # Specifies the subscripton to manage.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Object] $Subscription
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
        Write-Debug -Message ("Invoking GraphQL over WebSocket command: " + $uri)
        Write-Debug -Message "GraphQL over WebSocket command:"
        Write-Debug -Message $command
        $sendCommand = New-Object ArraySegment[byte] -ArgumentList @(, $([Text.Encoding]::ASCII.GetBytes($command)))
        $result = $webSocket.SendAsync($sendCommand, [Net.WebSockets.WebSocketMessageType]::Text, $true, $cancellationToken)
        while (-Not $result.IsCompleted) {
            Start-Sleep -Milliseconds 10
        }
        Write-Debug -Message "WebSocket status:"
        Write-Debug -Message ($webSocket | Select-Object * | Out-String)
        Write-Debug -Message "WebSocket operation result:"
        Write-Debug -Message ($result | Select-Object * | Out-String)
        if ($result.Result.CloseStatus) {
            throw "Send failed: $($result.Result.CloseStatusDescription) [$($result.Result.CloseStatus)]"
        }
        Write-Verbose "Unsubscribe (stop) request sent"
    }
}
