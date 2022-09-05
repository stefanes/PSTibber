$functionsRoot = Join-Path $PSScriptRoot functions
foreach ($file in Get-ChildItem -Path "$functionsRoot" -Filter *-*.ps1 -Recurse) {
    . $file.FullName
}

# Export all aliases and verb-noun functions
Export-ModuleMember -Alias * -Function *-*
