$moduleName = 'TridentCC.Common'
$repositoryName = "$($moduleName)-local"
$Version = (Import-PowerShellDataFile -Path ".\source\$moduleName\$moduleName.psd1").ModuleVersion
$artifactsFolder = Join-Path -Path ".\" -ChildPath "artifacts"

if (-not (Test-Path -Path $artifactsFolder -ErrorAction SilentlyContinue)) {
    New-Item -ItemType directory -Path $artifactsFolder
}

if ( $null -ne (Get-InstalledModule -Name $moduleName -ErrorAction SilentlyContinue)) {
    unInstall-Module $moduleName
}

# if ( $null -ne (Get-Module -Name "$($moduleName)" -ErrorAction SilentlyContinue )) {
#     Write-Warning "true $moduleName module"
# }

if ( $null -ne (Get-PSRepository -Name $repositoryName -ErrorAction SilentlyContinue)) {

    Unregister-PSRepository -Name $repositoryName
}

$Artifact = Join-Path -Path $artifactsFolder -ChildPath "$($moduleName).$($Version).nupkg"

if ((Test-Path -Path $Artifact -ErrorAction SilentlyContinue)) {
    Remove-Item -Path $Artifact
}

Register-PSRepository -Name $repositoryName -SourceLocation $artifactsFolder -InstallationPolicy Trusted

Publish-Module -Path ".\build\$($moduleName)\$($Version)" -Repository $repositoryName -NuGetApiKey 'use real NuGetApiKey for real nuget server here'

Get-PSRepository -Name $repositoryName

Find-Module -Name "$($moduleName)" -Repository $repositoryName | Select-Object Name, Version
