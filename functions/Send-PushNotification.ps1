function Send-PushNotification {
    <#
    .Synopsis
        Send push notifications to the Tibber app on registered devices.
    .Description
        Calling this function will send push notifications to the Tibber app on registered devices.
    .Example
        Send-PushNotification -Title 'Hello' -Message 'World!' -ScreenToOpen CONSUMPTION
    .Link
        Invoke-TibberQuery
    .Link
        https://developer.tibber.com/docs/reference#pushnotificationinput
    #>
    param (
        # Specifies the title of the push notification.
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('Subject')]
        [string] $Title,

        # Specifies the body of the push notification.
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [Alias('Body')]
        [string] $Message,

        # Specifies the app screent to open.
        # https://developer.tibber.com/docs/reference#appscreen
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateSet('HOME', 'REPORTS', 'CONSUMPTION', 'COMPARISON', 'DISAGGREGATION', 'HOME_PROFILE', 'CUSTOMER_PROFILE', 'METER_READING', 'NOTIFICATIONS', 'INVOICES')]
        [Alias('AppScreen')]
        [string] $ScreenToOpen = 'HOME'
    )

    dynamicParam {
        $dynamicParameters = Invoke-TibberQuery -DynamicParameter
        return $dynamicParameters
    }

    process {
        # Construct the GraphQL query
        $query = "mutation{ sendPushNotification(input: { message: `"$Message`""
        if ($Title) {
            $query += ", title: `"$Title`""
        }
        if ($ScreenToOpen) {
            $query += ", screenToOpen: $ScreenToOpen"
        }
        $query += "}){ successful, pushedToNumberOfDevices, __typename }}" # close query

        # Setup parameters
        $dynamicParametersValues = @{ }
        foreach ($key in $dynamicParameters.Keys) {
            if ($PSBoundParameters[$key]) {
                $dynamicParametersValues[$key] = $PSBoundParameters[$key]
            }
        }
        $splat = @{
            Query = $query
        } + $dynamicParametersValues

        # Call the GraphQL query API
        $out = Invoke-TibberQuery @splat

        # Output the object
        $out = $out.sendPushNotification
        $out | Add-TypeName -PSTypeName $out.__typename -PassThru
    }
}
