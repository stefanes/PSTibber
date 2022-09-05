﻿param(
    [string] $ModuleName = 'PSTibber'
)

# Install/update platyPS
if (-Not $(Get-Module -Name platyPS)) {
    Install-Module -Name platyPS -Repository PSGallery -Scope CurrentUser -Force -PassThru
}
else {
    Update-Module -Name platyPS
}
Import-Module -Name platyPS -Force -PassThru

# Module details
$moduleDirectory = "$PSScriptRoot\.."
$moduleDocs = "$moduleDirectory/docs/functions"
$manifestPath = Join-Path -Path $moduleDirectory -ChildPath "$ModuleName.psd1"

# Import self
Import-Module -Name $manifestPath -Force -PassThru

# Create markdown help documents
$generatedDocs = New-MarkdownHelp -Module $ModuleName -OutputFolder $moduleDocs -NoMetadata -Force
foreach ($doc in $generatedDocs) {
    $docText = [IO.File]::ReadAllText($doc.FullName)
    [IO.File]::WriteAllText($doc.FullName, ($docText -replace '\[(?<l>[^\]]+)\]\(\)', '[${l}](${l}.md)'))
    $doc
}
