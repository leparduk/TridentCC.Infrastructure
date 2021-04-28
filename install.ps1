$moduleName = 'TridentCC.Common'
$repositoryName = "$($moduleName)-local"

$artifactsFolder = Join-Path -Path ".\" -ChildPath "artifacts"

if ( $null -eq (Get-PSRepository -Name $repositoryName -ErrorAction SilentlyContinue)) {

    $Registered = $true
    Register-PSRepository -Name $repositoryName -SourceLocation $artifactsFolder -InstallationPolicy Trusted
}

Install-Module "$($moduleName)" -Repository $repositoryName

if ($Registered ) {

    Unregister-PSRepository -Name "$moduleName-local"

    $exists = Get-PSRepository -Name "$moduleName-local" -ErrorAction SilentlyContinue

    if ($exists) {
        Write-Error "local repository not removed"
    }
}

Get-InstalledModule -Name $moduleName -AllVersions | Select-Object Name, Version
