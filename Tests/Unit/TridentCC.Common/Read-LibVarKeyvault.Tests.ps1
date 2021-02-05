Describe "Read-LibVar" {

    Context "Parameter Tests" -Foreach @(
        @{ 'Name' = 'projectFromName'; 'Type' = 'String'; 'MandatoryFlag' = $true; 'ParameterSet' = '__AllParameterSets' }
        @{ 'Name' = 'groupFromName'; 'Type' = 'String'; 'MandatoryFlag' = $true; 'ParameterSet' = '__AllParameterSets' }
        @{ 'Name' = 'varFromName'; 'Type' = 'String'; 'MandatoryFlag' = $true; 'ParameterSet' = '__AllParameterSets' }
    ) {

        BeforeAll {
            $commandletUnderTest = "Read-LibVarKeyVault"
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

}
