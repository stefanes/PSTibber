# Invoke-TibberQuery

## SYNOPSIS
Send a request to the Tibber GraphQL API.

## SYNTAX

### URI (Default)
```
Invoke-TibberQuery [-URI <Uri>] [-Query <String>] [-PersonalAccessToken <String>] [-UserAgent <String>]
 [-Force] [-DebugResponse] [<CommonParameters>]
```

### GetDynamicParameters
```
Invoke-TibberQuery [-Query <String>] [-PersonalAccessToken <String>] [-UserAgent <String>] [-Force]
 [-DebugResponse] [-DynamicParameter] [<CommonParameters>]
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
Override default using the TIBBER_API_URI environment variable.

```yaml
Type: Uri
Parameter Sets: URI
Aliases: URL

Required: False
Position: Named
Default value: $(
            if ($env:TIBBER_API_URI) {
                $env:TIBBER_API_URI
            }
            else {
                'https://api.tibber.com/v1-beta/gql'
            }
        )
Accept pipeline input: False
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

### -PersonalAccessToken
Specifies the access token to use for the communication.
Override default using the TIBBER_ACCESS_TOKEN environment variable.

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
        )
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserAgent
Specifies the user agent (appended to the default).
Override default using the TIBBER_USER_AGENT environment variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $(
            if ($script:TibberUserAgentCache) {
                $script:TibberUserAgentCache
            }
            elseif ($env:TIBBER_USER_AGENT) {
                $env:TIBBER_USER_AGENT
            }
        )
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Switch to force a refresh of any cached results.

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

### -DebugResponse
{{ Fill DebugResponse Description }}

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

