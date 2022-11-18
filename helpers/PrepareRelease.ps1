param(
    [string] $ModuleName = 'PSTibber'
)

& $PSScriptRoot\RunPSScriptAnalyzer.ps1 -ModuleName $ModuleName
Start-Sleep -Seconds 3
& $PSScriptRoot\RunPester.ps1 -ModuleName $ModuleName
Start-Sleep -Seconds 3
& $PSScriptRoot\GenerateFormatting.ps1 -ModuleName $ModuleName
Start-Sleep -Seconds 3
& $PSScriptRoot\GenerateDocs.ps1 -ModuleName $ModuleName
