$Module = 'TridentCC.Common'
$Version = "1.0.0"

New-Item -ItemType directory -Path  ./publish -force

Register-PSRepository -Name "$($Module)-local" -SourceLocation '.\publish\' -InstallationPolicy Trusted

Publish-Module -Path ".\artifacts\$($Module)\$($Version)" -Repository "$($Module)-local" -NuGetApiKey 'use real NuGetApiKey for real nuget server here'

Install-Module "$($Module)" -Repository "$($Module)-local"

Get-PSRepository
