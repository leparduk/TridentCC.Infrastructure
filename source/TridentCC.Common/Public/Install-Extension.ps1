function Install-Extension {
    <#
    .SYNOPSIS
        Validates the Installation of an extension
    .DESCRIPTION
        The Install-Extension cmdlet checks whether an azure devops extension is installed and if not installs it
    .PARAMETER extensionName
        Name of Extension to install if not already installed
    .EXAMPLE
        Install-Extension -extensionName "application-insights"
    .NOTES
        There should be notes.
    .LINK
        https://docs.microsoft.com/en-us/cli/azure/extension?view=azure-cli-latest
#>
    [CmdletBinding()]
    [OutputType([System.String])]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $extensionName
    )
    begin {
        Set-StrictMode -Version Latest
    }
    process {

        $InformationPreference = 'Continue'

        $extensions = az extension list -o json | ConvertFrom-Json

        $extensionFound = $False
        foreach ($extension in $extensions) {
            if ($extension.name -eq $extensionName) {
                $extensionFound = $True

                Write-Information "$extensionName Found"

                break
            } # endif
        } # end foreach

        if ($extensionFound -eq $False) {

            Write-Information "Attempting to Install $extensionName"

            az extension add -n $extensionName
        }
    }
}
