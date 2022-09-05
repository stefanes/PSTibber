# PSTibber

PowerShell module for accessing the Tibber API.

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

You must have Tibber account to access the API. A *Personal Access Token* can be generated at <https://developer.tibber.com>.

To authenticate, pass the generated access token using the `-PersonalAccessToken` parameter with each call or set the `TIBBER_ACCESS_TOKEN` environment variable:

```powershell
$env:TIBBER_ACCESS_TOKEN = "<your access token>"
```

## Usage

Use `Get-Command -Module PSTibber` for a list of functions provided by this module. See the help associated with each function using the `Get-Help` command, e.g. `Get-Help Get-TibberUser -Detailed`, and the documentation available [in `docs`](docs/) for more details.

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

### Examples

#### Get logged-in user detail

```powershell
Get-TibberUser
```

#### Get Id of home

```powershell
$response = Get-TibberHome -Fields 'id', 'appNickname' -IncludeFeatures
($response | ? { $_.appNickname -eq 'Vitahuset' }).id | Tee-Object -Variable homeId
```

#### Get size of main fuse

```powershell
(Get-TibberHome -Fields 'mainFuseSize' -Id $homeId).mainFuseSize
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
