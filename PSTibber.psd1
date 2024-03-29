﻿@{
    Description      = 'PowerShell module for accessing the Tibber GraphQL API'
    ModuleVersion    = '0.6.3'
    RootModule       = 'PSTibber.psm1'
    Author           = 'Stefan Eskelid'
    Copyright        = 'Copyright 2023 Stefan Eskelid. All rights reserved.'
    Guid             = '1cbb2e45-4430-4188-9631-51aadb487982'
    PrivateData      = @{
        PSData = @{
            # Prerelease   = 'beta1'
            Tags         = 'Tibber'
            ProjectURI   = 'https://github.com/stefanes/PSTibber'
            LicenseURI   = 'https://github.com/stefanes/PSTibber/blob/main/LICENSE'
            ReleaseNotes = "See https://github.com/stefanes/PSTibber/blob/main/CHANGELOG.md"
        }
    }
    FormatsToProcess = 'PSTibber.format.ps1xml'
}
