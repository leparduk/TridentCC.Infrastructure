$Module = 'TridentCC.Common'

unRegister-PSRepository -Name "$Module-local"

Remove-Item -Recurse -Force ./publish

Get-PSRepository
