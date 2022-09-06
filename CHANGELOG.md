# Changelog

## Version 0.2.0

* :warning: BREAKING CHANGE: Renamed function `Invoke-TibberGraphQLQuery` to `Invoke-TibberQuery`.
* :heavy_exclamation_mark: Support for the live measurement API (#3)
* :new: New functions for communication over WebSockets:
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
