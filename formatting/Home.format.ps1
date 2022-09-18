Write-FormatView -TypeName Home -Property 'Home Id', Name, Size, 'Main fuse', Address, Owner, EAN, Grid, Subscription, 'Live measurements' -VirtualProperty @{
    'Home Id'           = {
        $($_.id)
    }
    Name                = {
        $($_.appNickname)
    }
    Size                = {
        "$($_.size) m2"
    }
    'Main fuse'         = {
        "$($_.mainFuseSize) A"
    }

    # IncludeAddress
    Address             = {
        $out = "$("$($_.address.address1) $($_.address.address2) $($_.address.address3)".TrimEnd())"
        if ($_.address.postalCode) {
            $out += ", $($_.address.postalCode) $($_.address.city)"
        }
        $out # output object
    }

    # IncludeOwner
    Owner               = {
        $out = "$($_.owner.name) <$($_.owner.contactInfo.email)>"
        if ($_.owner.contactInfo.mobile) {
            $out += ", $($_.owner.contactInfo.mobile)"
        }
        $out # output object
    }

    # IncludeMetering
    EAN                 = {
        $out = "$($_.meteringPointData.consumptionEan) (consumption)"
        if ($_.meteringPointData.productionEan) {
            $out += " / $($_.meteringPointData.productionEan) (production)"
        }
        $out # output object
    }
    Grid                = {
        "$($_.meteringPointData.priceAreaCode) ($($_.meteringPointData.gridCompany), $($_.meteringPointData.gridAreaCode))"
    }

    # IncludeSubscription
    Subscription        = {
        "Valid from $($_.currentSubscription.validFrom)"
    }

    # IncludeFeatures
    'Live measurements' = {
        $_.features.realTimeConsumptionEnabled
    }
} -ConditionalProperty @{
    Address             = { $_.address }
    Owner               = { $_.owner }
    EAN                 = { $_.meteringPointData }
    Grid                = { $_.meteringPointData }
    Subscription        = { $_.currentSubscription }
    'Live measurements' = { $_.features.realTimeConsumptionEnabled }
} -AsList
