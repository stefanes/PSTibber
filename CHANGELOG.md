# Changelog

## Version 0.3.1 (beta)

* Support for todays and tomorrows energy prices in [`Get-TibberPriceInfo`](docs/functions/Get-TibberPriceInfo.md).
* Improved debugging capabilities, see [here](README.md#debugging).

## Version 0.3.0

* :warning: BREAKING CHANGE: [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md) now, like [`Invoke-TibberQuery`](docs/functions/Invoke-TibberQuery.md), returns the recieved data converted from Json instead of the raw data as a string.
* :new: Added retry functionality to [`Connect-TibberWebSocket`](docs/functions/Connect-TibberWebSocket.md). ([#5](https://github.com/stefanes/PSTibber/issues/5))

## Version 0.2.0

* :warning: BREAKING CHANGE: Renamed function `Invoke-TibberGraphQLQuery` to `Invoke-TibberQuery`.
* :new: Support for the live measurement API ([#3](https://github.com/stefanes/PSTibber/issues/3)) with these new functions:
  * [`Connect-TibberWebSocket`](docs/functions/Connect-TibberWebSocket.md)
  * [`Register-TibberLiveConsumptionSubscription`](docs/functions/Register-TibberLiveConsumptionSubscription.md)
  * [`Read-TibberWebSocket`](docs/functions/Read-TibberWebSocket.md)
  * [`Unregister-TibberLiveConsumptionSubscription`](docs/functions/Unregister-TibberLiveConsumptionSubscription.md)
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
