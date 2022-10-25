[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '')]
param(
    [string] $ModuleName = 'PSTibber'
)

Write-Host "Running PSScriptAnalyzer: $ModuleName" -ForegroundColor Blue

# Install/update PSScriptAnalyzer
if (-Not $(Get-Module -Name PSScriptAnalyzer )) {
    Install-Module -Name PSScriptAnalyzer -Repository PSGallery -Scope CurrentUser -Force -PassThru
}
else {
    Update-Module -Name PSScriptAnalyzer
}
Import-Module -Name PSScriptAnalyzer  -Force -PassThru

# Module details
$moduleDirectory = Join-Path -Path $PSScriptRoot -ChildPath '..' -Resolve
$manifestPath = Join-Path -Path $moduleDirectory -ChildPath "$ModuleName.psd1"

# Import self
Import-Module -Name $manifestPath -Force -PassThru

# Run PSScriptAnalyzer
$splat = @{
    Path    = $moduleDirectory
    Recurse = $true
}
$result = Invoke-ScriptAnalyzer @splat -ErrorAction Continue
$errorCount = (@(, $result) | Where-Object { $_.Severity -eq 'Error' }).Count

# Handle the PSScriptAnalyzer test result
foreach ($r in $result) {
    $properties = "sourcepath=$($r.ScriptPath);LineNumber=$($r.Line);columnnumber=$($r.Column)"
    if (@('Information', 'Warning') -contains $r.Severity) {
        Write-Host "##vso[task.logissue type=warning;$properties]$($r.RuleName) : $($r.Message)"
    }
    elseif ($r.Severity -eq 'Error') {
        Write-Host "##vso[task.logissue type=error;$properties]$($r.RuleName) : $($r.Message)"
    }
}

# Exit script
if ($errorCount -gt 0) {
    Write-Host "##vso[task.complete result=Failed;]DONE"
    exit 1
}

# Exit script
Write-Host "PSScriptAnalyzer done: $ModuleName" -ForegroundColor Blue
exit 0
