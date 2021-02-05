Import-Module -Name Pester -MinimumVersion 5.1.0

# PesterConfiguration
$PesterConfiguration = [PesterConfiguration]::Default
$PesterConfiguration.Run.Exit = $false
$PesterConfiguration.CodeCoverage.Enabled = $false
$PesterConfiguration.Output.Verbosity = 'Detailed'
$PesterConfiguration.Run.PassThru = $true
$PesterConfiguration.Should.ErrorAction = 'Stop'

#Invoke-PSQualityCheck -Path @('.\Scripts') -recurse -ScriptAnalyzerRulesPath @('../ScriptAnalyzerRules/Indented.CodingConventions/', '../PSScriptAnalyzer/Tests/Engine/CommunityAnalyzerRules/', '../InjectionHunter/') -HelpRulesPath '.\HelpRules.psd1' -PesterConfiguration $PesterConfiguration

# Project Based
$Result = Invoke-PSQualityCheck -ProjectPath '.\' -ScriptAnalyzerRulesPath @('../ScriptAnalyzerRules/Indented.CodingConventions/', '../PSScriptAnalyzer/Tests/Engine/CommunityAnalyzerRules/', '../InjectionHunter/') -HelpRulesPath '.\HelpRules.psd1' -PassThru -PesterConfiguration $PesterConfiguration

if ($Result.Script.FailedCount -eq 0 -and $Result.Project.FailedCount -eq 0) {

    #Build-Module -debug .\source\TridentCC.Common\build.psd1

    Build-Module -debug .\source\TridentCC.Azure\build.psd1
}
else {
    Write-Information 'Modules not build - there were errors'
}
