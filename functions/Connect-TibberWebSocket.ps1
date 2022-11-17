function Connect-TibberWebSocket {
    <#
    .Synopsis
        Create a new GraphQL over WebSocket connection.
    .Description
        Calling this function will return a connection object for the established WebSocket connection.
        The object returned is intended to be used with other functions for communication with the endpoint.
    .Example
        $connection = Connect-TibberWebSocket
        Write-Host "New connection created: $($connection.WebSocket.State)"
    .Link
        https://docs.microsoft.com/en-us/dotnet/api/system.net.websockets.clientwebsocket
    .Link
        https://github.com/enisdenjo/graphql-ws/blob/master/PROTOCOL.md
    .Link
        https://developer.tibber.com/docs/guides/calling-api
    #>
    param (
        # Specifies the home Id, e.g. '96a14971-525a-4420-aae9-e5aedaa129ff'.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string] $HomeId,

        # Specifies the number of retry attempts if WebSocket initialization fails.
        [ValidateRange(0, [int]::MaxValue)]
        [Alias('Retries', 'MaxRetries')]
        [int] $RetryCount = 5,

        # Specifies the time to wait for WebSocket operations, or -1 to wait indefinitely.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(-1, [int]::MaxValue)]
        [Alias('Timeout')]
        [int] $TimeoutInSeconds = 10
    )

    dynamicParam {
        $dynamicParameters = Invoke-TibberQuery -DynamicParameter
        return $dynamicParameters
    }

    begin {
        # Setup parameters
        $dynamicParametersValues = @{ }
        foreach ($key in $dynamicParameters.Keys) {
            if ($PSBoundParameters[$key]) {
                $dynamicParametersValues[$key] = $PSBoundParameters[$key]
            }
        }
        $querySplat = @{
            WarningAction = 'Ignore'
        } + $dynamicParametersValues
        $querySplat.Force = $true

        # Get the WebSocket subscription URI
        # Note: Will cache access token and user agent (if provided)
        $querySplat.Query = "{ viewer { websocketSubscriptionUrl } }"
        [Uri] $wssUri = (Invoke-TibberQuery @querySplat).viewer.websocketSubscriptionUrl
        Write-Verbose -Message "Got the WebSocket subscription URI: $wssUri"

        # Setup request headers
        $fullUserAgent = Get-UserAgent -UserAgent $script:TibberUserAgentCache
    }

    process {
        $retryCounter = $RetryCount
        while ($retryCounter-- -ge 0) {
            # If this is a retry, release used resources
            if ($webSocket) {
                $webSocket.Dispose()
                $cancellationTokenSource.Dispose()
            }

            # Verify realtime device availability
            if (-Not $dynamicParametersValues.Force) {
                $querySplat.Query = "{ viewer { home(id:`"$HomeId`"){ features { realTimeConsumptionEnabled } } } }"
                $realTimeConsumptionEnabled = (Invoke-TibberQuery @querySplat).viewer.home.features.realTimeConsumptionEnabled
                if (-Not $realTimeConsumptionEnabled) {
                    throw "No realtime device available, please try again after making sure your device is properly connected and reporting data"
                }
                Write-Verbose -Message "Verified realtime device availability: $realTimeConsumptionEnabled"
            }

            # Setup WebSocket for communication
            $webSocket = New-Object Net.WebSockets.ClientWebSocket
            $webSocket.Options.AddSubProtocol('graphql-transport-ws')
            if ($PSVersionTable.PSVersion.Major -gt 5) {
                $webSocket.Options.SetRequestHeader('User-Agent', $fullUserAgent)
            }
            $cancellationTokenSource = New-Object Threading.CancellationTokenSource
            $cancellationToken = $cancellationTokenSource.Token
            $recvBuffer = New-Object ArraySegment[byte] -ArgumentList @(, $([byte[]] @(, 0) * 16384))

            # Connect WebSocket
            $result = $webSocket.ConnectAsync($wssUri, $cancellationToken)
            Wait-WebSocketOp -OperationName 'ConnectAsync' -Result $result -TimeoutInSeconds $TimeoutInSeconds
            Write-Verbose -Message "WebSocket connected to $wssUri [User agent = $fullUserAgent]"

            # Init WebSocket
            $command = @{
                type    = 'connection_init'
                payload = @{
                    token = $script:TibberAccessTokenCache
                }
            }
            if ($PSVersionTable.PSVersion.Major -le 5) {
                $command.payload.userAgent = $fullUserAgent
            }
            $command = $command | ConvertTo-Json -Depth 10
            Write-WebSocket -Data $command -WebSocket $webSocket -CancellationToken $cancellationToken -TimeoutInSeconds $TimeoutInSeconds
            Write-Verbose -Message "Init message sent to: $wssUri [connection_init]"

            # WebSocket init acknowledgement
            # Note: Not using 'Read-WebSocket', need the reslut object for retries
            $result = $webSocket.ReceiveAsync($recvBuffer, $cancellationToken)
            Wait-WebSocketOp -OperationName 'ReceiveAsync' -Result $result -TimeoutInSeconds $TimeoutInSeconds -IgnoreError:$($retryCounter -gt 0)
            Write-Debug -Message "WebSocket status:"
            Write-Debug -Message ($webSocket | Select-Object * | Out-String)
            if ($result.Result.CloseStatus) {
                if ($retryCounter -gt 0) {
                    $retryWaitTime = Get-WebSockerConnectWaitTime -Retry ($RetryCount - $retryCounter)
                    Write-Verbose -Message "Retrying in $retryWaitTime seconds, $retryCounter attempts left"
                    Start-Sleep -Seconds $retryWaitTime
                    continue
                }
            }
            $response = [Text.Encoding]::ASCII.GetString($recvBuffer.Array, 0, $result.Result.Count)
            Write-Verbose -Message "Init response: $response"

            # Output connection object
            return [PSCustomObject]@{
                HomeId                  = $HomeId
                URI                     = $wssUri
                WebSocket               = $webSocket
                CancellationTokenSource = $cancellationTokenSource
                ConnectionAttempts      = $RetryCount - $retryCounter
            }
        }
    }
}
