# Read-TibberWebSocket

## SYNOPSIS
Read packages on the provided WebSocket connection.

## SYNTAX

```
Read-TibberWebSocket [-Connection] <Object> [-Callback] <ScriptBlock> [[-TimeoutInSeconds] <Int32>]
 [[-Count] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Calling this function will read packages on the provided WebSocket connection.

## EXAMPLES

### EXAMPLE 1
```
Read-TibberWebSocket -Connection $connection -Callback { param($package)
    Write-Host "New package on WebSocket connection: $package"
}
```

### EXAMPLE 2
```
function Write-PackageToHost {
    param (
        [string] $package
    )
    Write-Host "New package on WebSocket connection: $package"
}
Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost}
```

### EXAMPLE 3
```
$result = Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -TimeoutInSeconds 30
Write-Host "Read $($result.NumberOfPackages) packages in $($result.ElapsedTimeInSeconds) seconds"
```

### EXAMPLE 4
```
Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -Count 3
Write-Host "Read $($result.NumberOfPackages) packages in $($result.ElapsedTimeInSeconds) seconds"
```

## PARAMETERS

### -Connection
Specifies the connection to use for the communication.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Callback
Specifies the script block called for each response.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TimeoutInSeconds
Specifies for how long in seconds we should read packages, or -1 to read indefinitely.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: -1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Count
Specifies the number of packages to read, or -1 to read indefinitely.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: -1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Connect-TibberWebSocket](Connect-TibberWebSocket.md)

[https://developer.tibber.com/docs/reference#livemeasurement](https://developer.tibber.com/docs/reference#livemeasurement)

