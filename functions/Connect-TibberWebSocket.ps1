﻿function Connect-TibberWebSocket {
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
        # Specifies the access token to use for the communication.
        # Override default using the TIBBER_ACCESS_TOKEN environment variable.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('PAT', 'AccessToken', 'Token')]
        [string] $PersonalAccessToken = $(
            if ($script:TibberAccessTokenCache) {
                $script:TibberAccessTokenCache
            }
            elseif ($env:TIBBER_ACCESS_TOKEN) {
                $env:TIBBER_ACCESS_TOKEN
            }
        ),

        # Specifies the number of retry attempts if WebSocket initialization fails.
        [ValidateRange(0, [int]::MaxValue)]
        [Alias('Retries', 'MaxRetries')]
        [int] $RetryCount = 5,

        # Specifies the time to wait for WebSocket operations, or -1 to wait indefinitely.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateRange(-1, [int]::MaxValue)]
        [Alias('Timeout')]
        [int] $TimeoutInSeconds = 10,

        # Specifies the user agent (appended to the default).
        # Override default using the TIBBER_USER_AGENT environment variable.
        [Parameter(ValueFromPipelineByPropertyName)]
        [string] $UserAgent = $(
            if ($env:TIBBER_USER_AGENT) {
                $env:TIBBER_USER_AGENT
            }
        )
    )

    begin {
        # Get GraphQL subscriptions endpoint
        $query = "{ viewer { websocketSubscriptionUrl } }"
        [Uri] $wssUri = (Invoke-TibberQuery -Query $query -PersonalAccessToken $PersonalAccessToken).viewer.websocketSubscriptionUrl

        # Setup request headers
        $fullUserAgent = "PSTibber/$($MyInvocation.MyCommand.ScriptBlock.Module.Version)"
        if ($UserAgent) {
            $fullUserAgent += " $UserAgent"
        }
        else {
            Write-Warning "Missing user agent, please set using '-UserAgent' or '`$env:TIBBER_USER_AGENT'"
        }
    }

    process {
        $retryCounter = $RetryCount
        while ($retryCounter-- -ge 0) {
            # If this is a retry, release used resources
            if ($webSocket) {
                $webSocket.Dispose()
                $cancellationTokenSource.Dispose()
            }

            # Setup WebSocket for communication
            $webSocket = New-Object Net.WebSockets.ClientWebSocket
            $webSocket.Options.AddSubProtocol('graphql-transport-ws')
            $webSocket.Options.SetRequestHeader('User-Agent', $fullUserAgent)
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
                    token = $PersonalAccessToken
                }
            } | ConvertTo-Json -Depth 10
            Write-WebSocket -Data $command -WebSocket $webSocket -CancellationToken $cancellationToken -TimeoutInSeconds $TimeoutInSeconds
            Write-Verbose -Message "Init message sent to: $wssUri [connection_init]"

            # WebSocket init acknowledgement
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
                URI                     = $wssUri
                WebSocket               = $webSocket
                CancellationTokenSource = $cancellationTokenSource
                RecvBuffer              = $recvBuffer
                ConnectionAttempts      = $RetryCount - $retryCounter
            }
        }
    }
}
