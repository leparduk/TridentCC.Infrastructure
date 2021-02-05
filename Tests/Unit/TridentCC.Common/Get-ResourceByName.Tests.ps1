Describe "Get-ResourceByName" {

    Context "Parameter Tests" -Foreach @(
        @{ 'Name' = 'ResourceGroupName'; 'Type' = 'String'; 'MandatoryFlag' = $true; 'ParameterSet' = '__AllParameterSets' }
        @{ 'Name' = 'ResourceName'; 'Type' = 'String'; 'MandatoryFlag' = $true; 'ParameterSet' = '__AllParameterSets' }
        @{ 'Name' = 'SubscriptionId'; 'Type' = 'String'; 'MandatoryFlag' = $false; 'ParameterSet' = '__AllParameterSets' }
    ) {

        BeforeAll {
            $commandletUnderTest = "Get-ResourceByName"
        }

        It "should have $Name as a mandatory parameter property set to $MandatoryFlag" {

            (Get-Command -Name $commandletUnderTest).Parameters[$Name].Name | Should -BeExactly $Name
            (Get-Command -Name $commandletUnderTest).Parameters[$Name].Attributes.Mandatory | Should -BeExactly $MandatoryFlag
        }

        It "should $Name belong to a $ParameterSet parameter set" {

            (Get-Command -Name $commandletUnderTest).Parameters[$Name].ParameterSets.Keys | Should -Be $ParameterSet
        }

        It "should $Name type be $Type" {

            (Get-Command -Name $commandletUnderTest).Parameters[$Name].ParameterType.Name | Should -Be $Type
        }

    }

    Context "Function tests" {

        It "should throw when passing null parameters" {
            {

                Get-ResourceByName -ResourceGroupName $null

            } | Should -Throw

            {

                Get-ResourceByName -ResourceName $null

            } | Should -Throw
        }
    }

    Context "Mock Tests" {

        BeforeAll {
            $ResourceGroupNameFilter = 'ResourceGroupName'
            $ResourceNameFilter = 'ResourceName'
            $ResourceGroupName = $ResourceGroupNameFilter
            $ResourceName = $ResourceNameFilter
        }

        BeforeEach {
            Mock Get-ResourceByName -ParameterFilter { $ResourceGroupName -eq $ResourceGroupNameFilter -and $ResourceName -eq $ResourceNameFilter } {
                #return @{'value' = 'ID' }
                return 'ID'
            }
        }

        It "should not throw when called with any ResourceGroupName and ResourceName" {

            {
                $Result = Get-ResourceByName -ResourceGroupName $ResourceGroupName -ResourceName $ResourceName

                Assert-MockCalled -CommandName Get-ResourceByName -Times 1 -ParameterFilter { $ResourceGroupName -eq $ResourceGroupNameFilter }

                $Result | Should -Be 'ID'

            } | Should -Not -Throw

        }

    }

}
