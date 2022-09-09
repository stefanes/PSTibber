[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
param()

BeforeAll {
    $TibberAccessToken = $env:TIBBER_ACCESS_TOKEN = "5K4MVS-OjfWhK_4yrjOlFe1F6kJXPVf7eQYggo8ebAE" # demo token
    $TibberURI = 'https://api.tibber.com/v1-beta/gql'
    $TibberHomeId = '96a14971-525a-4420-aae9-e5aedaa129ff'
    $TibberAddress = 'Winterfell Castle 1'
    $TibberEAN = '735999102107573183'
    $TibberEmail = 'arya@winterfell.com'
    $TibberWebSocket = @{
        connection   = $null
        subscription = $null
    }
}

Describe "Invoke-TibberQuery" {
    It "Can invoke GraphQL query" {
        $query = "{ viewer{ homes{ id } } }"
        (Invoke-TibberQuery -Query $query).viewer.homes[0].id | Should -Be $TibberHomeId
    }

    It "Fails when invalid query" {
        { Invoke-TibberQuery -Query "{}" } | Should -Throw
    }

    It "Fails when invalid query data" {
        Invoke-TibberQuery -Query "{ viewer{ home(id:`"__$TibberHomeId`"){ id }}}" -ErrorAction Ignore | Should -Be $null
    }

    It "Fails when invalid URI" {
        { Invoke-TibberQuery -URI $($TibberURI -replace '.com', '.net') -Query "{}" } | Should -Throw
    }
}

Describe "Get-TibberUser" {
    It "Can get user info" {
        (Get-TibberUser).login | Should -Be $TibberEmail
    }

    It "Can get user info (w/ access token)" {
        (Get-TibberUser -PersonalAccessToken $TibberAccessToken).login | Should -Be $TibberEmail
    }
}

Describe "Get-TibberHome" {
    It "Can get home info" {
        (Get-TibberHome).id | Should -Be $TibberHomeId
    }

    It "Can get home info by Id (w/ access token)" {
        (Get-TibberHome -PersonalAccessToken $TibberAccessToken -HomeId $TibberHomeId).id | Should -Be $TibberHomeId
    }

    It "Can get home address" {
        (Get-TibberHome -IncludeAddress).address.address1 | Should -Be $TibberAddress
    }

    It "Can get home owner" {
        (Get-TibberHome -IncludeOwner).owner.contactInfo.email | Should -Be $TibberEmail
    }

    It "Can get metering data" {
        (Get-TibberHome -IncludeMetering).meteringPointData.consumptionEan | Should -Be $TibberEAN
    }

    It "Can get subscription info" {
        (Get-TibberHome -IncludeSubscription).currentSubscription.subscriber.contactInfo.email | Should -Be $TibberEmail
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
        Get-TibberConsumption -PersonalAccessToken $TibberAccessToken -HomeId $TibberHomeId -Last 100 -FilterEmptyNodes | Should -Not -Be $null
    }
}

Describe "Get-TibberProduction" {
    It "Can get power production" {
        Get-TibberProduction | Should -Not -Be $null
    }

    It "Can get power production (w/ access token)" {
        Get-TibberProduction -PersonalAccessToken $TibberAccessToken -HomeId $TibberHomeId -Last 100 -FilterEmptyNodes | Should -Not -Be $null
    }
}

Describe "Get-TibberPriceInfo" {
    It "Can get power production" {
        Get-TibberPriceInfo -IncludeToday -IncludeTomorrow | Should -Not -Be $null
    }

    It "Can get power production (w/ access token)" {
        Get-TibberPriceInfo -PersonalAccessToken $TibberAccessToken -HomeId $TibberHomeId -Last 100 | Should -Not -Be $null
    }
}

Describe "Connect-TibberWebSocket" -Tag "graphql-ws" {
    It "Fails connecting WebSocket to wrong URI" {
        { Connect-TibberWebSocket -URI $TibberURI } | Should -Throw
    }

    It "Can connect WebSocket" {
        $TibberWebSocket.connection = Connect-TibberWebSocket
        $TibberWebSocket.connection.WebSocket | Should -Not -Be $null
    }
}

Describe "Register-TibberLiveConsumptionSubscription" -Tag "graphql-ws" {
    It "Can register subscription" {
        $TibberWebSocket.subscription = Register-TibberLiveConsumptionSubscription -Connection $TibberWebSocket.connection -HomeId $TibberHomeId
        $TibberWebSocket.subscription.Id | Should -Not -Be $null
    }
}

Describe "Read-TibberWebSocket" -Tag "graphql-ws" {
    It "Can read from WebSocket" {
        Read-TibberWebSocket -Connection $TibberWebSocket.connection -Callback { param($Json)
            $Json | Should -Not -Be $null
        } -PackageCount 1
    }
}

Describe "Unregister-TibberLiveConsumptionSubscription" -Tag "graphql-ws" {
    It "Can unregister subscription" {
        { Unregister-TibberLiveConsumptionSubscription -Connection $TibberWebSocket.connection -Subscription $TibberWebSocket.subscription } | Should -Not -Throw
    }
}

Describe "Disconnect-TibberWebSocket" -Tag "graphql-ws" {
    It "Can disconnect WebSocket" {
        { Disconnect-TibberWebSocket -Connection $TibberWebSocket.connection } | Should -Not -Throw
    }
}
