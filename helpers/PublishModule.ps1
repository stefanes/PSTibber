param(
    [string] $ModuleName = 'PSTibber',
    [string] $ApiKey = $env:PSGALLERY_API_KEY
)

# Module details
$moduleDirectory = Join-Path -Path $PSScriptRoot -ChildPath '..'
$manifestPath = Join-Path -Path $moduleDirectory -ChildPath "$ModuleName.psd1"

# Import self
Import-Module -Name $manifestPath -Force -PassThru

# Publish PowerShell module
$excludes = @(
    '.git\**'
    '.github\**'
    '.vscode\**'
    'docs\**'
    '.gitignore'
    'azure-pipelines.yml'
    'PSTibber.Tests.ps1'
    'README.md'
)
$splat = @{
    Name            = $manifestPath
    Repository      = 'PSGallery'
    Exclude         = $excludes
    NuGetApiKey     = $ApiKey
    AllowPrerelease = $true
    Force           = $true
}
Publish-Module @splat
