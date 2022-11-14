function Get-CacheKey {
    <#
    .Synopsis
        Get cache key.
    .Description
        Get a key for caching e.g. web request responses.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingBrokenHashAlgorithms', '')]
    param (
        # Specifies the data to base the key on.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('Input', 'Data')]
        [string] $InputData
    )

    process {
        # Calculate hash of input data
        $stream = [IO.MemoryStream]::New([byte[]][char[]] $InputData)
        $hash = Get-FileHash -InputStream $stream -Algorithm SHA1

        # Output cache key
        $hash.Hash.ToLower()
    }
}
