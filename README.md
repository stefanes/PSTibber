# PSTibber

PowerShell module for accessing the Tibber GraphQL API: <https://developer.tibber.com/docs/overview>

## Installation

Using the [latest version of PowerShellGet](https://www.powershellgallery.com/packages/PowerShellGet):

```powershell
Install-Module -Name PSTibber -Repository PSGallery -Scope CurrentUser -Force -PassThru
Import-Module -Name PSTibber -Force -PassThru
```

Or if you already have the module installed, update to the latest version:

```powershell
Update-Module -Name PSTibber
Import-Module -Name PSTibber -Force -PassThru
```

## Authentication

You must have Tibber account to access the API. A *Personal Access Token* can be generated at <https://developer.tibber.com/settings/access-token>.

To authenticate, pass the generated access token using the `-PersonalAccessToken` parameter with each call or set the `TIBBER_ACCESS_TOKEN` environment variable:

```powershell
$env:TIBBER_ACCESS_TOKEN = "<your access token>"
```

## Usage

Use `Get-Command -Module PSTibber` for a list of functions provided by this module. See the help associated with each function using the `Get-Help` command, e.g. `Get-Help Get-TibberUser -Detailed`, and the documentation available [in `docs`](docs/functions/) for more details.

If there is no function available for what you are trying to do, you can always use the `Invoke-TibberGraphQLQuery` function with a valid GraphQL query:

```powershell
$query = @"
{
  viewer {
    homes {
      id
      address {
        address1
      }
      owner {
        contactInfo {
          email
        }
      }
      consumption(resolution: HOURLY, last: 1) {
        nodes {
          from
          to
          cost
          unitPriceVAT
          consumption
        }
      }
      currentSubscription {
        priceInfo {
          current {
            total
            startsAt
          }
        }
      }
    }
  }
}
"@
$response = Invoke-TibberGraphQLQuery -Query $query
$response.viewer.homes[0]
```

*Tip: Develop your GraphQL query using the [Api Explorer](https://developer.tibber.com/explorer).*

### Examples

#### Get logged-in user detail

```powershell
$response = Get-TibberUser -Fields 'login', 'userId', 'name'
Write-Host "$($response.name) <$($response.login)> with user Id $($response.userId)"
```

#### Get home Id

```powershell
$response = Get-TibberHome -Fields 'id', 'appNickname' -IncludeFeatures
($response | ? { $_.appNickname -eq 'Vitahuset' }).id | Tee-Object -Variable homeId
```

#### Check if your home has a Tibber Pulse or Watty registered

```powershell
$response = Get-TibberHome -Fields 'appNickname' -IncludeFeatures -Id $homeId
Write-Host "Your home, $($response.appNickname), has real-time consumption $(
    if ([bool]::Parse($response.features.realTimeConsumptionEnabled)) {
        'enabled!'
    }
    else {
        'disabled...'
    }
    )"
```

#### Get the size of your main fuse

```powershell
(Get-TibberHome -Fields 'mainFuseSize' -Id $homeId).mainFuseSize
```

#### Get time of maimum energy price

```powershell
$response = Get-TibberPriceInfo -Last 10
$maxPrice = $response | Sort-Object -Property total -Descending | Select-Object -First 1
Write-Host "Max energy price, $($maxPrice.total) $($maxPrice.currency), starting at $(([DateTime]$maxPrice.startsAt).ToString('yyyy-MM-dd HH:mm')) [$($maxPrice.level)]"
```

#### Get time of maimum power consumption

```powershell
$response = Get-TibberConsumption -Last 10
$maxCons = $response | Sort-Object -Property consumption -Descending | Select-Object -First 1
Write-Host "Max power consumption $($maxCons.cost) $($maxCons.currency) ($($maxCons.consumption) $($maxCons.consumptionUnit) at $($maxCons.unitPrice)): $(([DateTime]$maxCons.from).ToString('HH:mm')) - $(([DateTime]$maxCons.to).ToString('HH:mm on yyyy-MM-dd'))"
```

#### Get time of maimum power production

```powershell
$response = Get-TibberProduction -Last 10
$maxProd = $response | Sort-Object -Property production -Descending | Select-Object -First 1
Write-Host "Max power production $($maxProd.profit) $($maxProd.currency) ($($maxProd.production) $($maxProd.productionUnit) at $($maxProd.unitPrice)): $(([DateTime]$maxProd.from).ToString('HH:mm')) - $(([DateTime]$maxProd.to).ToString('HH:mm on yyyy-MM-dd'))"
```

### Debugging

To view the actual GraphQL query sent in the requests, add the `-Debug` switch to the command.

Example:

```powershell
PS> Get-TibberUser -Debug
DEBUG: Invoking web request: POST https://api.tibber.com/v1-beta/gql
DEBUG: GraphQL query: { "query": "{ viewer{ login userId name accountType }}" }

login               userId                               name       accountType
-----               ------                               ----       -----------
arya@winterfell.com dcc2355e-6f55-45c2-beb9-274241fe450c Arya Stark {tibber, customer}
```
