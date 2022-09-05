[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '')]
param(
    [string] $ModuleName = 'PSTibber'
)

# Install/update PSScriptAnalyzer
if (-Not $(Get-Module -Name Pester )) {
    Install-Module -Name Pester -Repository PSGallery -Scope CurrentUser -Force -PassThru
}
else {
    Update-Module -Name Pester
}
Import-Module -Name Pester  -Force -PassThru

# Module details
$moduleDirectory = Join-Path -Path $PSScriptRoot -ChildPath '..'
$manifestPath = Join-Path -Path $moduleDirectory -ChildPath "$ModuleName.psd1"
$moduleTestResults = "$env:TEMP\$ModuleName.TestResults.xml"
$moduleCoverageReport = "$env:TEMP\$ModuleName.Coverage.xml"

# Import self
Import-Module -Name $manifestPath -Force -PassThru

# Run Pester
$overrides = @{
    Run          = @{
        Path     = $moduleDirectory
        PassThru = $true
    }
    CodeCoverage = @{
        Enabled               = $true
        OutputFormat          = 'JaCoCo'
        OutputPath            = $moduleCoverageReport
        Path                  = Join-Path -Path $moduleDirectory -ChildPath functions
        CoveragePercentTarget = [decimal]97
        #                        ^
        #                        └-- https://github.com/pester/Pester/issues/2108
    }
    TestResult   = @{
        Enabled      = $true
        OutputFormat = 'NUnitXml'
        OutputPath   = $moduleTestResults
    }
    Output       = @{
        Verbosity = 'Detailed'
    }
}
$config = New-PesterConfiguration -Hashtable $overrides
$result = Invoke-Pester -Configuration $config -ErrorAction Continue
$errorCount = $result.FailedCount

# Handle the Pester test result
foreach ($r in $result.TestResult) {
    if (-Not $r.Passed) {
        Write-Host "::error::$($r.describe, $r.context, $r.name -join ' ') $($r.FailureMessage)"
    }
}

# Exit script
if ($errorCount -gt 0) {
    exit 1
}
else {
    exit 0
}
