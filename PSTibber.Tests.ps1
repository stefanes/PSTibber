[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidGlobalVars', '')]
param()

$global:Pester_AccessToken = $env:TIBBER_ACCESS_TOKEN = "5K4MVS-OjfWhK_4yrjOlFe1F6kJXPVf7eQYggo8ebAE" # demo token
$global:Pester_HomeId = '96a14971-525a-4420-aae9-e5aedaa129ff'
$global:Pester_Address = 'Winterfell Castle 1'
$global:Pester_EAN = '735999102107573183'
$global:Pester_Email = 'arya@winterfell.com'

Describe "Invoke-TibberQuery" {
    It "Can invoke GraphQL query" {
        $query = "{ viewer{ homes{ id } } }"
        (Invoke-TibberQuery -Query $query).viewer.homes[0].id | Should -Be $Pester_HomeId
    }

    It "Fails when invalid query" {
        { Invoke-TibberQuery -Query "{}" } | Should -Throw
    }

    It "Fails when invalid query data" {
        Invoke-TibberQuery -Query "{ viewer{ home(id:`"$Pester_HomeId_`"){ id }}}" -ErrorAction Ignore | Should -Be $null
    }

    It "Fails when invalid URI" {
        { Invoke-TibberQuery -URI 'https://api.tibber.com/v1-alpha/gql' -Query "{}" } | Should -Throw
    }
}

Describe "Get-TibberUser" {
    It "Can get user info" {
        (Get-TibberUser).login | Should -Be $Pester_Email
    }

    It "Can get user info (w/ access token)" {
        (Get-TibberUser -PersonalAccessToken $Pester_AccessToken).login | Should -Be $Pester_Email
    }
}

Describe "Get-TibberHome" {
    It "Can get home info" {
        (Get-TibberHome).id | Should -Be $Pester_HomeId
    }

    It "Can get home info by Id (w/ access token)" {
        (Get-TibberHome -PersonalAccessToken $Pester_AccessToken -HomeId $Pester_HomeId).id | Should -Be $Pester_HomeId
    }

    It "Can get home address" {
        (Get-TibberHome -IncludeAddress).address.address1 | Should -Be $Pester_Address
    }

    It "Can get home owner" {
        (Get-TibberHome -IncludeOwner).owner.contactInfo.email | Should -Be $Pester_Email
    }

    It "Can get metering data" {
        (Get-TibberHome -IncludeMetering).meteringPointData.consumptionEan | Should -Be $Pester_EAN
    }

    It "Can get subscription info" {
        (Get-TibberHome -IncludeSubscription).currentSubscription.subscriber.contactInfo.email | Should -Be $Pester_Email
    }

    It "Can get home features" {
        (Get-TibberHome -IncludeFeatures).features.realTimeConsumptionEnabled | Should -BeTrue
    }
}

Describe "Get-TibberConsumption" {
    It "Can get power consumption" {
        Get-TibberConsumption | Should -Not -Be $null
    }

    It "Can get power consumption (w/ access token)" {
        Get-TibberConsumption -PersonalAccessToken $Pester_AccessToken -HomeId $Pester_HomeId -Last 100 -FilterEmptyNodes | Should -Not -Be $null
    }
}

Describe "Get-TibberProduction" {
    It "Can get power production" {
        Get-TibberProduction | Should -Not -Be $null
    }

    It "Can get power production (w/ access token)" {
        Get-TibberProduction -PersonalAccessToken $Pester_AccessToken -HomeId $Pester_HomeId -Last 100 -FilterEmptyNodes | Should -Not -Be $null
    }
}

Describe "Get-TibberPriceInfo" {
    It "Can get power production" {
        Get-TibberPriceInfo | Should -Not -Be $null
    }

    It "Can get power production (w/ access token)" {
        Get-TibberPriceInfo -PersonalAccessToken $Pester_AccessToken -HomeId $Pester_HomeId -Last 100 | Should -Not -Be $null
    }
}

Describe "Connect-TibberWebSocket" {
    It "Can connect WebSocket" {
        $global:connection = Connect-TibberWebSocket
        $connection.WebSocket | Should -Not -Be $null
    }
}

Describe "Register-TibberLiveConsumptionSubscription" {
    It "Can register subscription" {
        $global:subscription = Register-TibberLiveConsumptionSubscription -Connection $connection -HomeId $Pester_HomeId
        $subscription.Id | Should -Not -Be $null
    }
}

Describe "Read-TibberWebSocket" {
    It "Can read from WebSocket" {
        Read-TibberWebSocket -Connection $connection -Callback {} -PackageCount 1 | Should -Not -Be $null
    }
}

Describe "Unregister-TibberLiveConsumptionSubscription" {
    It "Can unregister subscription" {
        { Unregister-TibberLiveConsumptionSubscription -Connection $connection -Subscription $subscription } | Should -Not -Throw
    }
}

Describe "Disconnect-TibberWebSocket" {
    It "Can disconnect WebSocket" {
        { Disconnect-TibberWebSocket -Connection $connection } | Should -Not -Throw
    }
}
