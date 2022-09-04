# PSTibber
PowerShell module for accessing the Tibber API.

## Installation
Using the [latest version of PowerShellGet](https://www.powershellgallery.com/packages/PowerShellGet):
```
Install-Module -Name PSTibber -Repository PSGallery -Scope CurrentUser -Force -PassThru
Import-Module -Name PSTibber -Force -PassThru
```

Or if you already have the module installed:
```
Update-Module -Name PSTibber
Import-Module -Name PSTibber -Force -PassThru
```

## Authorization
You must have Tibber account to access the API. Access token can be generated at https://developer.tibber.com.
