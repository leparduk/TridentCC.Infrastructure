
if (-not (Get-Module PSDepend -ListAvailable)) {
    Install-Module PSDepend -Repository (Get-PSRepository)[0].Name -Scope CurrentUser
}

Invoke-PSDepend -Path install.depend.psd1 -Confirm:$false
