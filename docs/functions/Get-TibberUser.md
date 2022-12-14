# Get-TibberUser

## SYNOPSIS
Get information about the logged-in user.

## SYNTAX

```
Get-TibberUser [[-Fields] <String[]>] [-URI <Uri>] [-PersonalAccessToken <String>] [-UserAgent <String>]
 [-Force] [-DebugResponse] [<CommonParameters>]
```

## DESCRIPTION
Calling this function will return information about the logged-in user.

## EXAMPLES

### EXAMPLE 1
```
$response = Get-TibberUser -Fields 'login', 'userId', 'name'
Write-Host "$($response.name) <$($response.login)> with user Id $($response.userId)"
```

## PARAMETERS

### -Fields
Specifies the fields to return.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: @(
            'login'
            'userId'
            'name'
            'accountType'
            'websocketSubscriptionUrl'
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

### -Force
{{ Fill Force Description }}

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

### -URI
{{ Fill URI Description }}

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: URL

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserAgent
{{ Fill UserAgent Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

[https://developer.tibber.com/docs/reference#viewer](https://developer.tibber.com/docs/reference#viewer)

