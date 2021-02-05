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
    Write-Information 'Modules not build - there wwere errors'
}

<#
$Result

Name                           Value
----                           -----
script                         [+] Pester
extractedscript
module
project
extraction

(base) PS D:\Repos\TridentCC.Infrastructure> $Result.Script

Containers            : {[+] C:\Users\andre\.templateengine\Documents\PowerShell\Modules\PSQualityCheck\1.3.0\Checks\Script.Tests.ps1}
Result                : Passed
FailedCount           : 0
FailedBlocksCount     : 0
FailedContainersCount : 0
PassedCount           : 135
SkippedCount          : 9
NotRunCount           : 0
TotalCount            : 144
Duration              : 00:00:21.6530758
Executed              : True
ExecutedAt            : 04/02/2021 16:16:43
Version               : 5.1.0
PSVersion             : 7.1.1
PSBoundParameters     : {[Configuration, PesterConfiguration]}
Plugins               :
PluginConfiguration   :
PluginData            :
Configuration         : PesterConfiguration
DiscoveryDuration     : 00:00:00.2678640
UserDuration          : 00:00:19.7739068
FrameworkDuration     : 00:00:01.6113050
Failed                : {}
FailedBlocks          : {}
FailedContainers      : {}
Passed                : {[+] check script has valid PowerShell syntax, [+] check help must contain required elements, [+] check help must not contain unspecified elements, [+] check help elements text is not empty…}
Skipped               : {[!] check Import-Module statements have valid format, [!] check Import-Module statements have valid format, [!] check Import-Module statements have valid format, [!] check Import-Module statements have valid format…}
NotRun                : {}
Tests                 : {[+] check script has valid PowerShell syntax, [+] check help must contain required elements, [+] check help must not contain unspecified elements, [+] check help elements text is not empty…}

#>
