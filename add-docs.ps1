$moduleName = 'TridentCC.Common'

Install-Module -Name platyPS

. .\publish.ps1

. .\install.ps1

New-MarkdownHelp -Module "$($moduleName)" -OutputFolder .\docs

Remove-Module -Name "$($moduleName)"

. .\uninstall.ps1

. .\unpublish.ps1

#Get-Module

#Get-PSRepository
