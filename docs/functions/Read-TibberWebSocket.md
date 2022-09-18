# Read-TibberWebSocket

## SYNOPSIS
Read packages on the provided WebSocket connection.

## SYNTAX

```
Read-TibberWebSocket [-Connection] <Object> [-Callback] <ScriptBlock> [[-CallbackArgumentList] <Object[]>]
 [[-DurationInSeconds] <Int32>] [[-ReadUntil] <DateTime>] [[-PackageCount] <Int32>]
 [[-TimeoutInSeconds] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Calling this function will read packages on the provided WebSocket connection.

## EXAMPLES

### EXAMPLE 1
```
Read-TibberWebSocket -Connection $connection -Callback { param($Json)
    Write-Host "New Json document received: $($Json.payload.data | Out-String)"
}
```

### EXAMPLE 2
```
function Write-PackageToHost {
    param (
        [Object] $Json
    )
    Write-Host "New Json document received: $($Json.payload.data | Out-String)"
}
Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost}
```

### EXAMPLE 3
```
$result = Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -DurationInSeconds 30
Write-Host "Read $($result.NumberOfPackages) package(s) in $($result.ElapsedTimeInSeconds) seconds"
```

### EXAMPLE 4
```
Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -PackageCount 3
Write-Host "Read $($result.NumberOfPackages) package(s) in $($result.ElapsedTimeInSeconds) seconds"
```

### EXAMPLE 5
```
function Write-PackageToHost {
    param (
        [Object] $Json,
        [string] $With,
        [string] $Additional,
        [int] $Arguments
    )
    Write-Host "New Json document received: $($Json.payload.data | Out-String)"
    Write-Host "$With $Additional $Arguments"
}
Read-TibberWebSocket -Connection $connection -Callback ${function:Write-PackageToHost} -CallbackArgumentList @("Hello", "world!", 2022)
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
Specifies the script block/function called for each response.

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

### -CallbackArgumentList
Specifies the optional arguments passed on to the callback script block, positioned after the response.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: CallbackArguments, Arguments

Required: False
Position: 3
Default value: @()
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DurationInSeconds
Specifies for how long in seconds we should read packages, or -1 to read indefinitely.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Duration

Required: False
Position: 4
Default value: -1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ReadUntil
Specifies a date/time to read data until (a deadline).

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: Until, Deadline

Required: False
Position: 5
Default value: ([DateTime]::Now).AddSeconds(-1)
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PackageCount
Specifies the number of packages to read, or -1 to read indefinitely.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Count

Required: False
Position: 6
Default value: -1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TimeoutInSeconds
Specifies the time to wait for WebSocket operations, or -1 to wait indefinitely.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: Timeout

Required: False
Position: 7
Default value: 30
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Register-TibberLiveMeasurementSubscription](Register-TibberLiveMeasurementSubscription.md)

[https://developer.tibber.com/docs/reference#livemeasurement](https://developer.tibber.com/docs/reference#livemeasurement)

