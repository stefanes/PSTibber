﻿[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '')]
param(
    [string] $ModuleName = 'PSTibber',
    [int] $Count = 100,
    [switch] $Verbose,
    [switch] $Debug
)

Write-Host "Running load test: $ModuleName" -ForegroundColor Blue

# Module details
$moduleDirectory = Join-Path -Path $PSScriptRoot -ChildPath '..' -Resolve
$manifestPath = Join-Path -Path $moduleDirectory -ChildPath "$ModuleName.psd1"

# Import self
Import-Module -Name $manifestPath -Force -PassThru

$counter = 0
while ($counter++ -lt $Count) {
    $connection = Connect-TibberWebSocket -HomeId '96a14971-525a-4420-aae9-e5aedaa129ff' -Verbose:$Verbose -Debug:$Debug
    $subscription = Register-TibberLiveMeasurementSubscription -Connection $connection -Verbose:$Verbose -Debug:$Debug
    $result = Read-TibberWebSocket -Connection $connection -Callback {} -PackageCount 1 -Verbose:$Verbose -Debug:$Debug
    Write-Host "[$counter] Read $($result.NumberOfPackages) packages in $($result.ElapsedTimeInSeconds) seconds | Connection attempts: $($connection.ConnectionAttempts)"
    Unregister-TibberLiveMeasurementSubscription -Connection $connection -Subscription $subscription -Verbose:$Verbose -Debug:$Debug
    Disconnect-TibberWebSocket -Connection $connection -Verbose:$Verbose -Debug:$Debug
}

# Exit script
Write-Host "Load test done: $ModuleName" -ForegroundColor Blue
exit 0
