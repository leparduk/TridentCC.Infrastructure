param (
    [string]$fileContent
)

Describe "GetPropByPath Script test" {

    BeforeAll {

        # Read the script file
        #$fileContent = Get-Content -Path $scriptName -Raw
        $parsedScript = [System.Management.Automation.Language.Parser]::ParseInput($fileContent, [ref]$null, [ref]$null)
        $params = $parsedScript.ParamBlock.Parameters

        $paramKeys = @()
        foreach ($param in $params) {
            $paramKeys += $param.Name.VariablePath.UserPath
        }

    }

    Context "Parameter Tests" -ForEach @(
        # @{ 'Name' = 'ResourceGroupName'; 'Type' = 'String'; 'MandatoryFlag' = $true; 'ParameterSet' = '__AllParameterSets' }
        # @{ 'Name' = 'storName'; 'Type' = 'String'; 'MandatoryFlag' = $true; 'ParameterSet' = '__AllParameterSets' }
        # @{ 'Name' = 'location'; 'Type' = 'String'; 'MandatoryFlag' = $true; 'ParameterSet' = '__AllParameterSets' }

        # @{ 'Name' = 'sku'; 'Type' = 'string'; 'MandatoryFlag' = $false; 'ParameterSet' = '__AllParameterSets' }
        # @{ 'Name' = 'allowpubaccess'; 'Type' = 'Boolean'; 'MandatoryFlag' = $false; 'ParameterSet' = '__AllParameterSets' }
        # @{ 'Name' = 'minTLS'; 'Type' = 'string'; 'MandatoryFlag' = $false; 'ParameterSet' = '__AllParameterSets' }

    ) {

        BeforeAll {
            #      $commandletUnderTest = "new-Storage"

            $testParam = $_

        }

        # It "should have $Name as a mandatory parameter property set to $MandatoryFlag" {

        #     (Get-Command -Name $commandletUnderTest).Parameters[$Name].Name | Should -BeExactly $Name
        #     (Get-Command -Name $commandletUnderTest).Parameters[$Name].Attributes.Mandatory | Should -BeExactly $MandatoryFlag
        # }

        # It "should $Name belong to a $ParameterSet parameter set" {

        #     (Get-Command -Name $commandletUnderTest).Parameters[$Name].ParameterSets.Keys | Should -Be $ParameterSet
        # }

        # It "should $Name type be $Type" {

        #     (Get-Command -Name $commandletUnderTest).Parameters[$Name].ParameterType.Name | Should -Be $Type
        # }

        It "check param <_.Name> exists" {

            # Write-Host ($paramKeys | Out-String) -ForegroundColor Cyan

            ($paramKeys -contains $testParam.Name) | Should -Be True

        }

    }

    # Context "Function tests" {

    #     It "should throw when passing null parameters" {
    #         {

    #             new-Storage -ResourceGroupName $null

    #         } | Should -Throw

    #         {

    #             new-Storage -storName $null

    #         } | Should -Throw

    #         {

    #             new-Storage -location $null

    #         } | Should -Throw
    #     }
    # }

    # Context "Mock Tests" {

    #     BeforeAll {
    #         $ResourceGroupNameFilter = 'ResourceGroupName'
    #         $storNameFilter = 'storName'
    #         $ResourceGroupName = $ResourceGroupNameFilter
    #         $storName = $storNameFilter
    #         $location = 'uk south'
    #     }

    #     BeforeEach {
    #         Mock new-Storage -ParameterFilter { $ResourceGroupName -eq $ResourceGroupNameFilter -and $storName -eq $storNameFilter -and -not [String]::IsNullOrEmpty($location) } {
    #             #return @{'value' = 'ID' }
    #             return 'ID'
    #         }
    #     }

    #     It "should not throw when called with any ResourceGroupName and storName" {

    #         {
    #             $Result = new-Storage -ResourceGroupName $ResourceGroupName -storName $storName -location $location

    #             Assert-MockCalled -CommandName new-Storage -Times 1 -ParameterFilter { $ResourceGroupName -eq $ResourceGroupNameFilter }

    #             $Result | Should -Be 'ID'

    #         } | Should -Not -Throw

    #     }

    # }

}
