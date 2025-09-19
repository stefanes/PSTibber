---
document type: cmdlet
external help file: PSTibber-Help.xml
HelpUri: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest
Locale: sv-SE
Module Name: PSTibber
ms.date: 09-19-2025
PlatyPS schema version: 2024-05-01
title: Invoke-TibberQuery
---

# Invoke-TibberQuery

## SYNOPSIS

Send a request to the Tibber GraphQL API.

## SYNTAX

### URI (Default)

```
Invoke-TibberQuery [-URI <uri>] [-Query <string>] [-PersonalAccessToken <string>]
 [-UserAgent <string>] [-Force] [-DebugResponse] [<CommonParameters>]
```

### GetDynamicParameters

```
Invoke-TibberQuery -DynamicParameter [-Query <string>] [-PersonalAccessToken <string>]
 [-UserAgent <string>] [-Force] [-DebugResponse] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Calling this function will return a custom object with data returned from the Tibber GraphQL API.

## EXAMPLES

### EXAMPLE 1

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

## PARAMETERS

### -DebugResponse

{{ Fill DebugResponse Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DynamicParameter

{{ Fill DynamicParameter Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases:
- DynamicParameters
ParameterSets:
- Name: GetDynamicParameters
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Force

Switch to force a refresh of any cached results.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PersonalAccessToken

Specifies the access token to use for the communication.
Override default using the TIBBER_ACCESS_TOKEN environment variable.

```yaml
Type: System.String
DefaultValue: >-
  $(
              if ($script:TibberAccessTokenCache) {
                  $script:TibberAccessTokenCache
              } elseif ($env:TIBBER_ACCESS_TOKEN) {
                  $env:TIBBER_ACCESS_TOKEN
              }
          )
SupportsWildcards: false
Aliases:
- PAT
- AccessToken
- Token
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Query

Specifies the GraphQL query.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -URI

Specifies the URI for the request.
Override default using the TIBBER_API_URI environment variable.

```yaml
Type: System.Uri
DefaultValue: >-
  $(
              if ($env:TIBBER_API_URI) {
                  $env:TIBBER_API_URI
              } else {
                  'https://api.tibber.com/v1-beta/gql'
              }
          )
SupportsWildcards: false
Aliases:
- URL
ParameterSets:
- Name: URI
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UserAgent

Specifies the user agent (appended to the default).
Override default using the TIBBER_USER_AGENT environment variable.

```yaml
Type: System.String
DefaultValue: >-
  $(
              if ($script:TibberUserAgentCache) {
                  $script:TibberUserAgentCache
              } elseif ($env:TIBBER_USER_AGENT) {
                  $env:TIBBER_USER_AGENT
              }
          )
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Uri

{{ Fill in the Description }}

### System.String

{{ Fill in the Description }}

## OUTPUTS

## NOTES

## RELATED LINKS

- [](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest)
- [](https://developer.tibber.com/docs/reference)
