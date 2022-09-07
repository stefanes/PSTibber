# Invoke-TibberQuery

## SYNOPSIS
Send a request to the Tibber GraphQL API.

## SYNTAX

### URI (Default)
```
Invoke-TibberQuery [-URI <Uri>] [-Query <String>] [-ContentType <String>] [-PersonalAccessToken <String>]
 [<CommonParameters>]
```

### GetDynamicParameters
```
Invoke-TibberQuery [-Query <String>] [-ContentType <String>] [-PersonalAccessToken <String>]
 [-DynamicParameter] [<CommonParameters>]
```

## DESCRIPTION
Calling this function will return a custom object with data returned from the Tibber GraphQL API.

## EXAMPLES

### EXAMPLE 1
```
$query = @"
{
    viewer {
        homes {
            id
        }
    }
}
"@
$response = Invoke-TibberQuery -Query $query
Write-Host "Home ID = $($response.viewer.homes[0].id)"
```

## PARAMETERS

### -URI
Specifies the URI for the request.

```yaml
Type: Uri
Parameter Sets: URI
Aliases: URL

Required: False
Position: Named
Default value: Https://api.tibber.com/v1-beta/gql
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Query
Specifies the GraphQL query.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ContentType
Specifies the content type of the request.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Application/json
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PersonalAccessToken
Specifies the access token to use for the communication.
demo token

```yaml
Type: String
Parameter Sets: (All)
Aliases: PAT, AccessToken, Token

Required: False
Position: Named
Default value: $(
            if ($script:TibberAccessTokenCache) {
                $script:TibberAccessTokenCache
            }
            elseif ($env:TIBBER_ACCESS_TOKEN) {
                $env:TIBBER_ACCESS_TOKEN
            }
            else {
                '5K4MVS-OjfWhK_4yrjOlFe1F6kJXPVf7eQYggo8ebAE' # demo token
            }
        )
Accept pipeline input: False
Accept wildcard characters: False
```

### -DynamicParameter
{{ Fill DynamicParameter Description }}

```yaml
Type: SwitchParameter
Parameter Sets: GetDynamicParameters
Aliases: DynamicParameters

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest)

[https://developer.tibber.com/docs/reference](https://developer.tibber.com/docs/reference)

