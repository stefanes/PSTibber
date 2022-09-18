param(
    [string] $ModuleName = 'PSTibber'
)

& $PSScriptRoot\GenerateFormatting.ps1 -ModuleName $ModuleName
& $PSScriptRoot\GenerateDocs.ps1 -ModuleName $ModuleName
& $PSScriptRoot\RunPSScriptAnalyzer.ps1 -ModuleName $ModuleName
& $PSScriptRoot\RunPester.ps1 -ModuleName $ModuleName
