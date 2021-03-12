Import-Module -Name Pester -MinimumVersion 5.1.0
Import-Module -Name PSQualityCheck -MinimumVersion 1.3.0

$InformationPreference = 'Continue'

# PesterConfiguration
$PesterConfiguration = [PesterConfiguration]::Default
$PesterConfiguration.Run.Exit = $false
$PesterConfiguration.CodeCoverage.Enabled = $false
$PesterConfiguration.Output.Verbosity = 'Detailed'
$PesterConfiguration.Run.PassThru = $true
$PesterConfiguration.Should.ErrorAction = 'Stop'

$ScriptRules = @(
    './Analyzer/ScriptAnalyzerRules/Indented.CodingConventions/'
    #, './Analyzer/PSScriptAnalyzer/Tests/Engine/CommunityAnalyzerRules/'
    #, './Analyzer/InjectionHunter/'
)

# Project Based
$Result = Invoke-PSQualityCheck -ProjectPath '.\' -ScriptAnalyzerRulesPath $ScriptRules -HelpRulesPath '.\HelpRules.psd1' -PassThru -PesterConfiguration $PesterConfiguration

if ($Result.Script.FailedCount -eq 0 -and $Result.Project.FailedCount -eq 0) {

    Build-Module .\source\TridentCC.Common\build.psd1
}
else {
    Write-Information 'Modules not build - there were errors'
}

$Result = Invoke-PSQualityCheck -Path @('.\Scripts\TridentCC.Azure') -recurse -ScriptAnalyzerRulesPath $ScriptRules -HelpRulesPath '.\HelpRules.psd1' -Passthru -PesterConfiguration $PesterConfiguration

if ($Result.Script.FailedCount -eq 0) {

    $Dest = ".\Release\TridentCC.Azure\1.0.0"
    # Copy Script files to release folder
    New-Item -ItemType Directory -Force -Path $Dest
    Copy-Item ".\Scripts\TridentCC.Azure\*.*" -Destination $Dest -Recurse -Force
}
else {
    Write-Information 'Scripts not exported - there were errors'
}
