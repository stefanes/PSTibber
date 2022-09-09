[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '')]
param(
    [string] $ModuleName = 'PSTibber',
    [int] $Count = 100
)

Write-Host "Running load test: $ModuleName" -ForegroundColor Yellow

# Module details
$moduleDirectory = Join-Path -Path $PSScriptRoot -ChildPath '..' -Resolve
$manifestPath = Join-Path -Path $moduleDirectory -ChildPath "$ModuleName.psd1"

# Import self
Import-Module -Name $manifestPath -Force -PassThru

$counter = 0
while ($counter++ -lt $Count) {
    $connection = Connect-TibberWebSocket
    $subscription = Register-TibberLiveConsumptionSubscription -Connection $connection -HomeId '96a14971-525a-4420-aae9-e5aedaa129ff'
    $result = Read-TibberWebSocket -Connection $connection -Callback {} -PackageCount 1
    Write-Host "[$counter] Read $($result.NumberOfPackages) packages in $($result.ElapsedTimeInSeconds) seconds | Connection attempts: $($connection.ConnectionAttempts)"
    Unregister-TibberLiveConsumptionSubscription -Connection $connection -Subscription $subscription
    Disconnect-TibberWebSocket -Connection $connection
}

# Exit script
Write-Host "Load test done: $ModuleName" -ForegroundColor Yellow
exit 0
