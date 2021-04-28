$moduleName = 'TridentCC.Common'
$repositoryName = "$($moduleName)-local"
$Version = (Import-PowerShellDataFile -Path ".\source\$moduleName\$moduleName.psd1").ModuleVersion

$Artifact = Join-Path -Path $artifactsFolder -ChildPath "$($moduleName).$($Version).nupkg"

if ((Test-Path -Path $Artifact -ErrorAction SilentlyContinue)) {
    Remove-Item -Path $Artifact
}

if ( $null -ne (Get-PSRepository -Name $repositoryName -ErrorAction SilentlyContinue)) {

    Unregister-PSRepository -Name $repositoryName
}

Get-PSRepository
