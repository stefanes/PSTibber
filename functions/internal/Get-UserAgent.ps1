function Get-UserAgent {
    <#
    .Synopsis
        Get the full user agent string.
    .Description
        Get the full user agent string, with the user provided user agend appended to the PSTibber user agent.
    #>
    param (
        # Specifies the user agent (appended to the default).
        [Parameter(ValueFromPipelineByPropertyName)]
        [string] $UserAgent,

        # Switch to supress warning.
        [switch] $SupressWarning
    )

    process {
        $fullUserAgent = "PSTibber/$($MyInvocation.MyCommand.ScriptBlock.Module.Version)"
        if ($UserAgent) {
            $fullUserAgent += " $UserAgent"
        }
        elseif (-Not $SupressWarning.IsPresent) {
            Write-Warning "Missing user agent, please set using '-UserAgent' or '`$env:TIBBER_USER_AGENT'"
        }

        # Output user agent
        $fullUserAgent
    }
}
