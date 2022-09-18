<#
.Synopsis
    Filter to decorate objects with PSTypeNames.
.Description
    Using this filter will set the objects PSTypeNames property to the provided values.
#>
filter Add-TypeName (
    # Specifies the PSTypeName to set.
    [string[]] $PSTypeName,

    # Switch to output decorated object.
    [switch] $PassThru
) {
    # If we have a PSTypeName (for applying formatting) and it is not an error (which we do not want to format)
    if ($PSTypeName -And $_ -IsNot [Management.Automation.ErrorRecord]) {
        # Clear the existing typenames and decorate the object
        $_.PSTypeNames.Clear()
        foreach ($t in $PSTypeName) {
            $_.PSTypeNames.add($t)
        }
    }

    # Pass object along
    if ($PassThru.IsPresent) {
        $_
    }
}
