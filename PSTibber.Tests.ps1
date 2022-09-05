$env:TIBBER_ACCESS_TOKEN = "5K4MVS-OjfWhK_4yrjOlFe1F6kJXPVf7eQYggo8ebAE" # demo token

Describe "Invoke-TibberGraphQLQuery" {
    It "Can invoke GraphQL query" {
        $query = "{ viewer{ homes{ id } } }"
        (Invoke-TibberGraphQLQuery -Query $query).viewer.homes[0].id | Should -Be '96a14971-525a-4420-aae9-e5aedaa129ff'
    }

    It "Fails when invalid query" {
        { Invoke-TibberGraphQLQuery -Query "{}" } | Should -Throw
    }

    It "Fails when invalid query data" {
        Invoke-TibberGraphQLQuery -Query "{ viewer{ home(id:`"96a14971-525a-4420-aae9-e5aedaa129ff_`"){ id }}}" -ErrorAction Ignore | Should -Be $null
    }

    It "Fails when invalid URI" {
        { Invoke-TibberGraphQLQuery -URI 'https://api.tibber.com/v1-alpha/gql' -Query "{}" } | Should -Throw
    }
}

Describe "Get-TibberUser" {
    It "Can get user info" {
        (Get-TibberUser).login | Should -Be 'arya@winterfell.com'
    }
}

Describe "Get-TibberHome" {
    It "Can get home info" {
        (Get-TibberHome).id | Should -Be '96a14971-525a-4420-aae9-e5aedaa129ff'
    }

    It "Can get home info by Id" {
        (Get-TibberHome -Id '96a14971-525a-4420-aae9-e5aedaa129ff').id | Should -Be '96a14971-525a-4420-aae9-e5aedaa129ff'
    }

    It "Can get home address" {
        (Get-TibberHome -IncludeAddress).address.address1 | Should -Be 'Winterfell Castle 1'
    }

    It "Can get home owner" {
        (Get-TibberHome -IncludeOwner).owner.contactInfo.email | Should -Be 'arya@winterfell.com'
    }

    It "Can get metering data" {
        (Get-TibberHome -IncludeMetering).meteringPointData.consumptionEan | Should -Be '735999102107573183'
    }

    It "Can get home features" {
        (Get-TibberHome -IncludeFeatures).features.realTimeConsumptionEnabled | Should -BeTrue
    }
}
