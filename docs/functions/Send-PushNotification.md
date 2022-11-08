# Send-PushNotification

## SYNOPSIS
Send push notifications to the Tibber app on registered devices.

## SYNTAX

```
Send-PushNotification [[-Title] <String>] [-Message] <String> [[-ScreenToOpen] <String>] [-URI <Uri>]
 [-PersonalAccessToken <String>] [-UserAgent <String>] [-Force] [-DebugResponse] [<CommonParameters>]
```

## DESCRIPTION
Calling this function will send push notifications to the Tibber app on registered devices.

## EXAMPLES

### EXAMPLE 1
```
Send-PushNotification -Title 'Hello' -Message 'World!' -ScreenToOpen CONSUMPTION
```

## PARAMETERS

### -Title
Specifies the title of the push notification.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Subject

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Message
Specifies the body of the push notification.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Body

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ScreenToOpen
Specifies the app screent to open.
https://developer.tibber.com/docs/reference#appscreen

```yaml
Type: String
Parameter Sets: (All)
Aliases: AppScreen

Required: False
Position: 3
Default value: HOME
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

[https://developer.tibber.com/docs/reference#pushnotificationinput](https://developer.tibber.com/docs/reference#pushnotificationinput)

