[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '')]
param(
    [string] $ModuleName = 'PSTibber'
)

Write-Host "Running platyPS: $ModuleName" -ForegroundColor Blue

# Install/update platyPS
if (-Not $(Get-Module -Name Microsoft.PowerShell.PlatyPS)) {
    Install-Module -Name Microsoft.PowerShell.PlatyPS -Repository PSGallery -Scope CurrentUser -Force -PassThru
} else {
    Update-Module -Name Microsoft.PowerShell.PlatyPS
}
Import-Module -Name Microsoft.PowerShell.PlatyPS -Force -PassThru

# Module details
$moduleDirectory = Join-Path -Path $PSScriptRoot -ChildPath '..' -Resolve
$moduleDocs = Join-Path -Path $moduleDirectory -ChildPath "docs\functions"
$manifestPath = Join-Path -Path $moduleDirectory -ChildPath "$ModuleName.psd1"

# Import self
Import-Module -Name $manifestPath -Force -PassThru

# Create markdown help documents
$generatedDocs = New-MarkdownCommandHelp -Module $(Get-Module $ModuleName) -OutputFolder $moduleDocs -Force
foreach ($doc in $generatedDocs) {
    $docText = [IO.File]::ReadAllText($doc.FullName)
    [IO.File]::WriteAllText($doc.FullName, ($docText -replace '\[(?<l>[^\]]+)\]\(\)', '[${l}](${l}.md)'))
    $doc
}
Move-Item -Path $(Join-Path -Path $moduleDocs -ChildPath $ModuleName -AdditionalChildPath '*') -Destination $moduleDocs -Force
Remove-Item -Path $(Join-Path -Path $moduleDocs -ChildPath $ModuleName) -Recurse -Force

# Exit script
Write-Host "platyPS done: $ModuleName [$moduleDocs]" -ForegroundColor Blue
exit 0
