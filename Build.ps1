Import-Module -Name Pester -MinimumVersion 5.1.0
Import-Module -Name PSQualityCheck -MinimumVersion 1.3.0

$InformationPreference = 'Continue'
$ErrorActionPreference = 'Stop'

# PesterConfiguration
$PesterConfiguration = [PesterConfiguration]::Default
$PesterConfiguration.Run.Exit = $false
$PesterConfiguration.CodeCoverage.Enabled = $false
$PesterConfiguration.Output.Verbosity = 'Detailed'
$PesterConfiguration.Run.PassThru = $true
$PesterConfiguration.Should.ErrorAction = 'Stop'

$ScriptRules = @(
    '../ScriptAnalyzerRules/Indented.CodingConventions/'
    #, './Analyzer/PSScriptAnalyzer/Tests/Engine/CommunityAnalyzerRules/'
    #, './Analyzer/InjectionHunter/'
)

function Get-FunctionFileContent {
    [CmdletBinding()]
    [OutputType([System.String[]])]
    param (
        [parameter(Mandatory = $true)]
        [string]$Path
    )

    try {
        $fileContent = Get-Content -Path $Path
        $parserErrors = $null
        if ([string]::IsNullOrEmpty($fileContent)) {
            $parsedFileFunctions = @()
        }
        else {
            $parsedFileFunctions = [System.Management.Automation.PSParser]::Tokenize($fileContent, [ref]$parserErrors)
        }
        $parsedFunctions = ($parsedFileFunctions | Where-Object { $_.Type -eq "Keyword" -and $_.Content -like 'function' })
        if ($parsedFunctions.Count -gt 1) {
            throw "Too many functions in file, file is invalid"
        }
        if ($parsedFunctions.Count -eq 0) {
            for ($line = 0; $line -lt $fileContent.Count; $line++) {
                $parsedFileContent += $fileContent[$line]
                $parsedFileContent += "`r`n"
            }
        }
        else {
            if ($fileContent.Count -gt 1) {
                foreach ($function in $parsedFunctions) {
                    $startLine = ($function.StartLine)
                    for ($line = $fileContent.Count - 1; $line -gt $function.StartLine; $line--) {
                        if ($fileContent[$line] -like "*}*") {
                            $endLine = $line
                            break
                        }
                    }
                    for ($line = $startLine; $line -lt $endLine; $line++) {
                        $parsedFileContent += $fileContent[$line]
                        if ($line -ne ($fileContent.Count - 1)) {
                            $parsedFileContent += "`r`n"
                        }
                    }
                }
            }
            else {
                [int]$startBracket = $fileContent.IndexOf('{')
                [int]$endBracket = $fileContent.LastIndexOf('}')
                $parsedFileContent = $fileContent.substring($startBracket + 1, $endBracket - 1 - $startBracket)
            }
        }
    }
    catch {
        throw
    }
    return $parsedFileContent
}

$sourcePath = Resolve-Path -Path "source"
$scriptsPath = Resolve-Path -Path "scripts"
$ignoreFile = Resolve-Path -Path ".psqcignore"

# Start of Project Based checks
$qualityCheckSplat = @{
    'ProjectPath'             = (Resolve-Path -Path '.\')
    'ScriptAnalyzerRulesPath' = $ScriptRules
    'HelpRulesPath'           = (Resolve-Path -Path '.\HelpRules.psd1')
    'Passthru'                = $true
    'PesterConfiguration'     = $PesterConfiguration
    'IgnoreFile'              = $ignoreFile
}
$qualityResult = Invoke-PSQualityCheck @qualityCheckSplat
# End of Project Based checks

# Running tests
if ($qualityResult.Script.FailedCount -eq 0 -and $qualityResult.Project.FailedCount -eq 0) {

    $testResults = @()

    # Run the unit tests for the public functions of any modules in the project

    # Get the modules (the directories in the Source folder)
    $modules = Get-ChildItem -Path $sourcePath -Directory

    foreach ($module in $modules) {

        # Get the public functions (minus any excluded by the ignore file)
        $functionFiles = @()
        $functionFiles += Get-FilteredChildItem -Path (Join-Path -Path $module.FullName -ChildPath "public") -IgnoreFileName $ignoreFile

        # If there are any scripts in the private folder with corresponding tests then run those too
        # $privateFunctionFiles += Get-ChildItem -Path (Join-Path -Path $Module.FullName -ChildPath "private")
        # Write-Host $privateFunctionFiles.Count -ForegroundColor Yellow
        # foreach ($function in $privateFunctionFiles) {
        #     Write-Host $function.FullName -ForegroundColor Yellow
        #     if (Test-Path -Path ".\tests\unit\$($module.BaseName)\$($function.BaseName).Tests.ps1") {
        #         $functionFiles += (Get-ChildItem -Path ".\tests\unit\$($module.BaseName)\$($function.BaseName).Tests.ps1")
        #     }
        # }

        foreach ($function in $functionFiles) {

            $fileContent = Get-FunctionFileContent -Path $function.FullName
            . "$($function.FullName)"

            $container = New-PesterContainer -Path ".\tests\unit\$($module.BaseName)\$($function.BaseName).Tests.ps1" -Data @{FileContent = $fileContent }
            $PesterConfiguration.Run.Container = $container

            $testResults += Invoke-Pester -Configuration $PesterConfiguration

        }
    }

    # TODO: Add integration tests here

}
else {
    # Write-Information 'Functions not tested - there were project quality check errors'
    # Write-Warning -Message "Project Quality Check fails"
    Write-Error -Message "Project quality check failed"
    break
}
# End of running tests

# Start of module build
# Build the module(s) only if there are no unit/integration test failures
$testFailedCount = 0

foreach ($result in $testResults) {
    $testFailedCount += $result.FailedCount
}

if ($testFailedCount -eq 0 ) {
    foreach ($module in $modules) {
        $buildPropertiesFile = ".\source\$($module.BaseName)\build.psd1"
        Build-Module -SourcePath $buildPropertiesFile
    }
}
else {
    Write-Error -Message 'One or more module were not built because there were function unit test errors'
    throw
}
# End of module build

# Run any available unit tests for files in Scripts folder
$scriptFiles = @()
$testResults = @()
$scriptFiles += Get-FilteredChildItem -Path $scriptsPath -IgnoreFileName $ignoreFile
foreach ($scriptFile in $scriptFiles) {

    $scriptFolder = $scriptFile.FullName -ireplace [regex]::Escape($scriptsPath.Path), ''
    $scriptFolder = $scriptFolder -ireplace [regex]::Escape($scriptFile.Name), ''

    $fileContent = Get-FunctionFileContent -Path $scriptFile.FullName

    $container = New-PesterContainer -Path ".\tests\scripts$scriptFolder\$($scriptFile.BaseName).Tests.ps1" -Data @{FileContent = $fileContent }
    $PesterConfiguration.Run.Container = $container

    $testResults += Invoke-Pester -Configuration $PesterConfiguration

}

$testFailedCount = 0

foreach ($result in $testResults) {
    $testFailedCount += $result.FailedCount
}

# If there are no script failures then copy the scripts to the Artifacts folder
if ($testFailedCount -eq 0) {
    $ArtifactsFolder = Resolve-Path -Path ".\artifacts"
    Copy-Item -Path "Scripts" -Destination $ArtifactsFolder -Recurse -Force -Container
}
else {
    Write-Error -Message "One or more scripts were not copied to artifact folder because there were failed unit tests"
    break
}
# End of script copy

### END OF SCRIPT
