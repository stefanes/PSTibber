Write-FormatView -TypeName PushNotificationResponse -Property Successful, NumberOfDevices -VirtualProperty @{
    NumberOfDevices = {
        $($_.pushedToNumberOfDevices)
    }
}
