$functionsRoot = Join-Path $PSScriptRoot functions
$publicFunctions = @( Get-ChildItem -Path "$functionsRoot\*.ps1" -Recurse -ErrorAction SilentlyContinue | `
        Where-Object { $_.FullName -notlike "$functionsRoot\internal\*" } )
$privateFunctions = @( Get-ChildItem -Path "$functionsRoot\internal\*.ps1" -Recurse -ErrorAction SilentlyContinue )

$allFunctions = $publicFunctions + $privateFunctions
foreach ($function in $AllFunctions) {
    try {
        . $function.Fullname
    }
    catch {
        Write-Error -Message "Failed to import function $($function.Fullname): $_"
    }
}

# Export the public functions
Export-ModuleMember -Function $publicFunctions.BaseName
