# Changelog

## Version 0.6.3

* [`Get-TibberConsumption`](docs/functions/Get-TibberConsumption.md) and [`Get-TibberProduction`](docs/functions/Get-TibberProduction.md) now knows how to return consumption/production data based on dates provided using the `-From`/`-To` parameters.

## Version 0.6.2

* Add support for Windows PowerShell (Note: PowerShell Core is recommended).

## Version 0.6.1

* :recycle: INTERNAL: Change format of cache keys.

## Version 0.6.0

* :warning: BREAKING CHANGE: Adapt [`Connect-TibberWebSocket`](docs/functions/Connect-TibberWebSocket.md) to new [requirements and best practices](https://developer.tibber.com/docs/guides/calling-api):
  * Repurposed the `-URI` parameter to reference the [API](docs/functions/Invoke-TibberQuery.md#-uri) instead of the (now dynamically obtained) WebSocket URI.
  * Removed the `-RetryWaitTimeInSeconds` parameter, the retry wait time is now [calculated dynamically](functions/internal/Get-WebSockerConnectWaitTime.ps1).
  * Introduced a new [`-HomeId`](docs/functions/Connect-TibberWebSocket.md#-homeid) parameter.
* :warning: BREAKING CHANGE: Removed the `-HomeId` parameter from [`Register-TibberLiveMeasurementSubscription`](docs/functions/Register-TibberLiveMeasurementSubscription.md), this information is now instead taken from the connection object.
* [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md) now has separate (optional) callbacks available for [`complete`](docs/functions/Read-TibberWebSocket.md#-callbackcomplete) and [`error`](docs/functions/Read-TibberWebSocket.md#-callbackerror) responses.
* In addition to the `TIBBER_USER_AGENT` environment variable, added a [`-UserAgent`](docs/functions/Invoke-TibberQuery.md#-useragent) parameter to all functions for setting the user agent.

## Version 0.5.3

* Set user agent header in [`Invoke-TibberQuery`](docs/functions/Invoke-TibberQuery.md) and [`Connect-TibberWebSocket`](docs/functions/Connect-TibberWebSocket.md). Append your own user agent with the `TIBBER_USER_AGENT` environment variable, see [README.md](README.md#usage).

## Version 0.5.2

* Override default using the `TIBBER_API_URI` environment variable in all `Get-*` functions, see [`Invoke-TibberQuery`](docs/functions/Invoke-TibberQuery.md).
* Add `websocketSubscriptionUrl` to the returned values from [`Get-TibberUser`](docs/functions/Get-TibberUser.md) (see the [Tibber API changelog](https://developer.tibber.com/docs/changelog)).
* Change default URI to `wss://websocket-api.tibber.com/v1-beta/gql/subscriptions` in [`Connect-TibberWebSocket`](docs/functions/Connect-TibberWebSocket.md).

## Version 0.5.1

* :recycle: INTERNAL: Make all cache keys lower case.

## Version 0.5.0

* :warning: BREAKING CHANGE: All `Get-*` functions now cache the response from the GraphQL endpoint by default, see [here](README.md#the-response-cache) for more details.

## Version 0.4.7

* [`Get-TibberPriceInfo`](docs/functions/Get-TibberPriceInfo.md) now knows how to filter out past prices with the `-ExcludePast` parameter.

## Version 0.4.6

* :new: NEW: Support for sending push notifications ([#13](https://github.com/stefanes/PSTibber/issues/13)) with [`Send-PushNotification`](docs/functions/Send-PushNotification.md).

## Version 0.4.5

* Added output formatting using [EZOut](https://github.com/StartAutomating/EZOut) - get the unformatted output by piping to `Select-Object *`, e.g. `Get-TibberUser | Select-Object *`.

## Version 0.4.4

* Fixed release notes link in [PowerShell Gallery](https://www.powershellgallery.com/packages/PSTibber).

## Version 0.4.3

* [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md) can now pass additional arguments to the callback script block/function, positioned **after** the response.

## Version 0.4.2

* :new: NEW: Renamed functions to better reflect purpose:
  * [`Register-TibberLiveMeasurementSubscription`](docs/functions/Register-TibberLiveMeasurementSubscription.md)
  * [`Unregister-TibberLiveMeasurementSubscription`](docs/functions/Unregister-TibberLiveMeasurementSubscription.md)

  _Note: Function aliases provided for backwards compatibility._

## Version 0.4.1

* :recycle: INTERNAL: Improved error handling.

## Version 0.4.0

* :warning: BREAKING CHANGE: Renamed the parameter `-TimeoutInSeconds` to `-DurationInSeconds` in [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md). `-TimeoutInSeconds` now instead represents the time to wait for WebSocket operations (see next bullet).
* Introduced a `-TimeoutInSeconds` parameter in all WebSocket functions representing the time to wait for WebSocket operations.
* [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md) now knows how to read until a specified date/time (a deadline), see [example](docs/graphql-ws.md#duration-deadline-or-max-package-count).

## Version 0.3.1

* Support for today's and tomorrow's energy prices in [`Get-TibberPriceInfo`](docs/functions/Get-TibberPriceInfo.md).
* Improved debugging capabilities, see [here](README.md#debugging).

## Version 0.3.0

* :warning: BREAKING CHANGE: [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md) now, like [`Invoke-TibberQuery`](docs/functions/Invoke-TibberQuery.md), returns the received data converted from `Json` instead of the raw data as a string.
* Added retry functionality to [`Connect-TibberWebSocket`](docs/functions/Connect-TibberWebSocket.md). ([#5](https://github.com/stefanes/PSTibber/issues/5))

## Version 0.2.0

* :warning: BREAKING CHANGE: Renamed function `Invoke-TibberGraphQLQuery` to [`Invoke-TibberQuery`](docs/functions/Invoke-TibberQuery.md).
* :new: NEW: Support for the live measurement API ([#3](https://github.com/stefanes/PSTibber/issues/3)) with these new functions:
  * [`Connect-TibberWebSocket`](docs/functions/Connect-TibberWebSocket.md)
  * [`Register-TibberLiveMeasurementSubscription`](docs/functions/Register-TibberLiveMeasurementSubscription.md)
  * [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md)
  * [`Unregister-TibberLiveMeasurementSubscription`](docs/functions/Unregister-TibberLiveMeasurementSubscription.md)
  * [`Disconnect-TibberWebSocket`](docs/functions/Disconnect-TibberWebSocket.md)

## Version 0.1.0

* Initial version, see [README.md](README.md#usage) for how to use this module.
* :new: NEW: Generic function for invoking any GraphQL query, [`Invoke-TibberQuery`](docs/functions/Invoke-TibberQuery.md).
* :new: NEW: Functions for getting user info, home info, energy price info, and energy consumtion/production data:
  * [`Get-TibberUser`](docs/functions/Get-TibberUser.md)
  * [`Get-TibberHome`](docs/functions/Get-TibberHome.md)
  * [`Get-TibberPriceInfo`](docs/functions/Get-TibberPriceInfo.md)
  * [`Get-TibberConsumption`](docs/functions/Get-TibberConsumption.md)
  * [`Get-TibberProduction`](docs/functions/Get-TibberProduction.md)
