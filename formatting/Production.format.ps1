Write-FormatView -TypeName Production -Property From, To, Price, Production, Profit -VirtualProperty @{
    Price      = {
        $value = ($_.unitPrice).ToString("0.00")
        "$value $($_.currency)"
    }
    Production = {
        $value = ($_.production).ToString("0.00")
        "$value $($_.productionUnit)"
    }
    Profit     = {
        $value = ($_.profit).ToString("0.00")
        "$value $($_.currency)"
    }
}
