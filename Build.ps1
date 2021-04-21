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
    # './Analyzer/ScriptAnalyzerRules/Indented.CodingConventions/'
    #, './Analyzer/PSScriptAnalyzer/Tests/Engine/CommunityAnalyzerRules/'
    #, './Analyzer/InjectionHunter/'
)

$project = $true
$script = $true

#  Project Based
if ($project) {

    $qualityResult = Invoke-PSQualityCheck -ProjectPath '.\' -ScriptAnalyzerRulesPath $ScriptRules -HelpRulesPath '.\HelpRules.psd1' -Passthru -PesterConfiguration $PesterConfiguration

    if ($qualityResult.Script.FailedCount -eq 0 -and $qualityResult.Project.FailedCount -eq 0) {

        $Modules = Get-ChildItem -Path ".\Source" -Directory

        $functionResults = @()

        foreach ($module in $Modules) {

            $FunctionFiles = @()

            $functionFiles += Get-ChildItem -Path (Join-Path -Path $Module.FullName -ChildPath "public")
            #$functionFiles += Get-ChildItem -Path (Join-Path -path $Module.FullName -ChildPath "private")

            foreach ($function in $functionFiles) {

                Write-Host ".\tests\unit\$($module.BaseName)\$($function.BaseName).Tests.psd1"

                . "$($function.FullName)"

                # $container = New-PesterContainer -Path ".\tests\unit\$($module.BaseName)\$($function.BaseName).Tests.ps1"
                # $PesterConfiguration.Run.Container = $container

                $functionResults += Invoke-Pester -Path ".\tests\unit\$($module.BaseName)\$($function.BaseName).Tests.ps1" -PassThru

            }
        }
    }
    else {

        # Write-Information 'Functions not tested - there were project quality check errors'
        # Write-Warning -Message "Project Quality Check fails"
        Write-Error -Message "Project Quality Check fails"
        break

    }

    #$functionResults | Out-String

    $failedCount = 0

    foreach ($result in $functionResults) {
        $failedCount += $result.FailedCount
    }

    if ($failedCount -eq 0 ) {

        foreach ($module in $Modules) {

            Build-Module ".\source\$($module.BaseName)\build.psd1" -Verbose
        }
    }
    else {

        Write-Information 'Modules not build - there were errors'
        throw

    }
}
# End of module build

# Script checks
if ($script) {

    $scriptFiles = Get-ChildItem -Path ".\Scripts" -Filter "*.ps1" -Recurse

    $scriptResults = @()

    foreach ($script in $scriptFiles) {

        if ($script.name -eq "subscriptions.ps1" -or $script.name -eq 'GetPropByPath.ps1') { continue }

        $Result = Invoke-PSQualityCheck -File $script.FullName -ScriptAnalyzerRulesPath $ScriptRules -HelpRulesPath '.\HelpRules.psd1' -Passthru -PesterConfiguration $PesterConfiguration

        $folder = Split-Path -Path $script.DirectoryName -Leaf

        Write-Host ".\tests\scripts\$folder\$($script.BaseName).Tests.ps1"
        if ((Test-Path -Path ".\tests\scripts\$folder\$($script.BaseName).Tests.ps1") -and $result.Script.FailedCount -eq 0) {

            Write-Host "I'm running a test, honest!" -ForegroundColor Magenta

            # . "$($script.FullName)"

            $container = New-PesterContainer -Path ".\tests\scripts\$folder\$($script.BaseName).Tests.ps1" -Data @{ScriptName = $script.FullName }
            $PesterConfiguration.Run.Container = $container

            $scriptResults += Invoke-Pester -Configuration $PesterConfiguration

        }

    }

    $failedCount = 0

    foreach ($result in $scriptResults) {
        $failedCount += $result.FailedCount
    }

    if ($FailedCount -eq 0) {

        $Dest = ".\artifacts"
        # Copy Script files to Artifact folder
        #New-Item -ItemType Directory -Force -Path $Dest
        Copy-Item ".\Scripts\*.*" -Destination $Dest -Recurse -Force -Verbose
    }
    else {
        Write-Information 'Scripts not exported - there were errors'
    }
}
