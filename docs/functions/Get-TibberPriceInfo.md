# Get-TibberPriceInfo

## SYNOPSIS
Get the price info for visible home(s).

## SYNTAX

### __AllParameterSets (Default)
```
Get-TibberPriceInfo [-ExcludeCurrent] [-IncludeToday] [-IncludeTomorrow] [-Last <Int32>] [-Resolution <String>]
 [-Fields <String[]>] [-PersonalAccessToken <String>] [-DebugResponse] [<CommonParameters>]
```

### HomeId
```
Get-TibberPriceInfo -HomeId <String> [-ExcludeCurrent] [-IncludeToday] [-IncludeTomorrow] [-Last <Int32>]
 [-Resolution <String>] [-Fields <String[]>] [-PersonalAccessToken <String>] [-DebugResponse]
 [<CommonParameters>]
```

## DESCRIPTION
Calling this function will return the price info for visible home(s).

## EXAMPLES

### EXAMPLE 1
```
$response = Get-TibberPriceInfo -Last 10
$maxPrice = $response | Sort-Object -Property total -Descending | Select-Object -First 1
Write-Host "Max energy price, $($maxPrice.total) $($maxPrice.currency), starting at $(([DateTime]$maxPrice.startsAt).ToString('yyyy-MM-dd HH:mm')) [$($maxPrice.level)]"
```

### EXAMPLE 2
```
$response = Get-TibberPriceInfo -IncludeToday
Write-Host "Todays energy prices: $($response | Out-String)"
```

### EXAMPLE 3
```
$response = Get-TibberPriceInfo -IncludeTomorrow
Write-Host "Tomorrows energy prices: $($response | Out-String)"
```

## PARAMETERS

### -HomeId
Specifies the home Id, e.g.
'96a14971-525a-4420-aae9-e5aedaa129ff'.

```yaml
Type: String
Parameter Sets: HomeId
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ExcludeCurrent
Switch to exclude current energy price from the results.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeToday
Switch to include todays energy price in the results.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTomorrow
Switch to include tomorrows energy price in the results, available after 13:00 CET/CEST.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Last
Specifies the number of nodes to include in results, counting back from the latest entry.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Resolution
Specifies the resoluton of the results (applicable only when '-Last' is provided).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: HOURLY
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Fields
Specifies the fields to return.
https://developer.tibber.com/docs/reference#price

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @(
            'total'
            'energy'
            'tax'
            'startsAt'
            'currency'
            'level'
        )
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DebugResponse
{{ Fill DebugResponse Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PersonalAccessToken
{{ Fill PersonalAccessToken Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: PAT, AccessToken, Token

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Invoke-TibberQuery](Invoke-TibberQuery.md)

[https://developer.tibber.com/docs/reference#priceinfo](https://developer.tibber.com/docs/reference#priceinfo)

