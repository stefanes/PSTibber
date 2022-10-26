[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '')]
param(
    [string] $ModuleName = 'PSTibber'
)

Write-Host "Running EZOut: $ModuleName" -ForegroundColor Blue

# Install/update platyPS
if (-Not $(Get-Module -Name EZOut)) {
    Install-Module -Name EZOut -Repository PSGallery -Scope CurrentUser -Force -PassThru
}
else {
    Update-Module -Name EZOut
}
Import-Module -Name EZOut -Force -PassThru

$moduleDirectory = Join-Path -Path $PSScriptRoot -ChildPath '..' -Resolve
Push-Location $moduleDirectory

$formatting = @(
    # Add your own Write-FormatView here, or declare them in a 'formatting' or 'views' directory
    foreach ($potentialDirectory in 'formatting', 'views') {
        Join-Path -Path $moduleDirectory -ChildPath $potentialDirectory |
        Get-ChildItem -ErrorAction Ignore |
        Import-FormatView -FilePath { $_.Fullname }
    }
)
if ($formatting) {
    # Note: Add "FormatsToProcess = '$ModuleName.format.ps1xml'" to module manifest
    $formatFile = Join-Path -Path $moduleDirectory -ChildPath "$ModuleName.format.ps1xml"
    $formatting | Out-FormatData -Module $ModuleName | Set-Content -Path $formatFile -Encoding UTF8
}

$types = @(
    # Add your own Write-TypeView here, or declare them in a 'types' directory
    Join-Path $moduleDirectory Types |
    Get-ChildItem -ErrorAction Ignore |
    Import-TypeView

)
if ($types) {
    # Note: Add "TypesToProcess = '$ModuleName.types.ps1xml'" to module manifest
    $typesFile = Join-Path -Path $moduleDirectory -ChildPath "$ModuleName.types.ps1xml"
    $types | Out-TypeData | Set-Content -Path $typesFile -Encoding UTF8
}

Pop-Location

Write-Host "EZOut done: $ModuleName" -ForegroundColor Blue
