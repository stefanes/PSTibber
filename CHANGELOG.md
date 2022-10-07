# Changelog

## Version 0.5.1

* :recycle: INTERNAL: Make all cache keys lower case.

## Version 0.5.0

* :warning: BREAKING CHANGE: All `Get` functions now cache the response from the GraphQL endpoint by default, see [here](README.md#the-response-cache) for more details.

## Version 0.4.7

* [`Get-TibberPriceInfo`](docs/functions/Get-TibberPriceInfo.md) now knows how filter out past prices with the `-ExcludePast` parameter.

## Version 0.4.6

* :new: Support for sending push notifications ([#13](https://github.com/stefanes/PSTibber/issues/13)) with [`Send-PushNotification`](docs/functions/Send-PushNotification.md).

## Version 0.4.5

* Added output formatting using [EZOut](https://github.com/StartAutomating/EZOut) - get the unformatted output by piping to `Select-Object *`, e.g. `Get-TibberUser | Select-Object *`.

## Version 0.4.4

* Fixed release notes link in [PowerShell Gallery](https://www.powershellgallery.com/packages/PSTibber).

## Version 0.4.3

* [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md) can now pass additional arguments to the callback script block/function, positioned **after** the response.

## Version 0.4.2

* :new: Renamed functions to better reflect purpose:
  * [`Register-TibberLiveMeasurementSubscription`](docs/functions/Register-TibberLiveMeasurementSubscription.md)
  * [`Unregister-TibberLiveMeasurementSubscription`](docs/functions/Unregister-TibberLiveMeasurementSubscription.md)

  _Note: Function aliases provided for backwards compatibility._

## Version 0.4.1

* :recycle: INTERNAL: Improved error handling.

## Version 0.4.0

* :warning: BREAKING CHANGE: Renamed the parameter `-TimeoutInSeconds` to `-DurationInSeconds` in [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md). `-TimeoutInSeconds` now instead represents the time to wait for WebSocket operations (see next bullet).
* Introduced a `-TimeoutInSeconds` parameter in all WebSocket functions representing the time to wait for WebSocket operations.
* [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md) now knows how to read until a specified data/time (a deadline), see [example](docs/graphql-ws.md#duration-deadline-or-max-package-count).

## Version 0.3.1

* Support for today's and tomorrow's energy prices in [`Get-TibberPriceInfo`](docs/functions/Get-TibberPriceInfo.md).
* Improved debugging capabilities, see [here](README.md#debugging).

## Version 0.3.0

* :warning: BREAKING CHANGE: [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md) now, like [`Invoke-TibberQuery`](docs/functions/Invoke-TibberQuery.md), returns the received data converted from `Json` instead of the raw data as a string.
* Added retry functionality to [`Connect-TibberWebSocket`](docs/functions/Connect-TibberWebSocket.md). ([#5](https://github.com/stefanes/PSTibber/issues/5))

## Version 0.2.0

* :warning: BREAKING CHANGE: Renamed function `Invoke-TibberGraphQLQuery` to [`Invoke-TibberQuery`](docs/functions/Invoke-TibberQuery.md).
* :new: Support for the live measurement API ([#3](https://github.com/stefanes/PSTibber/issues/3)) with these new functions:
  * [`Connect-TibberWebSocket`](docs/functions/Connect-TibberWebSocket.md)
  * [`Register-TibberLiveMeasurementSubscription`](docs/functions/Register-TibberLiveMeasurementSubscription.md)
  * [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md)
  * [`Unregister-TibberLiveMeasurementSubscription`](docs/functions/Unregister-TibberLiveMeasurementSubscription.md)
  * [`Disconnect-TibberWebSocket`](docs/functions/Disconnect-TibberWebSocket.md)

## Version 0.1.0

* Initial version, see [README.md](README.md#usage) for how to use this module.
* :new: Generic function for invoking any GraphQL query, [`Invoke-TibberQuery`](docs/functions/Invoke-TibberQuery.md).
* :new: Functions for getting user info, home info, energy price info, and energy consumtion/production data:
  * [`Get-TibberUser`](docs/functions/Get-TibberUser.md)
  * [`Get-TibberHome`](docs/functions/Get-TibberHome.md)
  * [`Get-TibberPriceInfo`](docs/functions/Get-TibberPriceInfo.md)
  * [`Get-TibberConsumption`](docs/functions/Get-TibberConsumption.md)
  * [`Get-TibberProduction`](docs/functions/Get-TibberProduction.md)
