# Get-TibberProduction

## SYNOPSIS
Get the visible home(s) power production.

## SYNTAX

### __None (Default)
```
Get-TibberProduction [-Resolution <String>] [-Last <Int32>] [-FilterEmptyNodes] [-Fields <String[]>]
 [-PersonalAccessToken <String>] [<CommonParameters>]
```

### HomeId
```
Get-TibberProduction -HomeId <String> [-Resolution <String>] [-Last <Int32>] [-FilterEmptyNodes]
 [-Fields <String[]>] [-PersonalAccessToken <String>] [<CommonParameters>]
```

## DESCRIPTION
Calling this function will return the visible home(s) power production.

## EXAMPLES

### EXAMPLE 1
```
$response = Get-TibberProduction -Last 10
$maxProd = $response | Sort-Object -Property production -Descending | Select-Object -First 1
Write-Host "Max power production $($maxProd.profit) $($maxProd.currency) ($($maxProd.production) $($maxProd.productionUnit) at $($maxProd.unitPrice)): $(([DateTime]$maxProd.from).ToString('HH:mm')) - $(([DateTime]$maxProd.to).ToString('HH:mm on yyyy-MM-dd'))"
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

### -Resolution
Specifies the resoluton of the results.

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

### -Last
Specifies the number of nodes to include in results, counting from the latest entry.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FilterEmptyNodes
Switch to filter out empty nodes (i.e.
production is '0') from results.

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

### -Fields
Specifies the fields to return.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @(
            'from'
            'to'
            'unitPrice'
            'unitPriceVAT'
            'production'
            'productionUnit'
            'profit'
            'currency'
        )
Accept pipeline input: True (ByPropertyName)
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

[https://developer.tibber.com/docs/reference#production](https://developer.tibber.com/docs/reference#production)

