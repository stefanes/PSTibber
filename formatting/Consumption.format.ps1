Write-FormatView -TypeName Consumption -Property From, To, Price, Consumption, Cost -VirtualProperty @{
    Price       = {
        $value = ($_.unitPrice).ToString("0.00")
        "$value $($_.currency)"
    }
    Consumption = {
        $value = ($_.consumption).ToString("0.00")
        "$value $($_.consumptionUnit)"
    }
    Cost        = {
        $value = ($_.cost).ToString("0.00")
        "$value $($_.currency)"
    }
}
