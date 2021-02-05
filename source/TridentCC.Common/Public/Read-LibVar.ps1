
function Read-LibVar {
    <#
    .SYNOPSIS
        Read a Variable from a Group in a Project.
    .DESCRIPTION
        Read a Variable from a Group in a Project.
    .PARAMETER projectFromName
        The Name of the Project to read from
    .PARAMETER groupFromName
        The name of the Library to read from
    .PARAMETER varFromName
        The name of the key to read from
    .EXAMPLE
        read-LibVar -ProjectFromName "" -groupFromName "" -varFromName ""
    .NOTES
        There should be notes.
    .LINK
        There should be a link
#>
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $projectFromName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $groupFromName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $varFromName
    )
    begin {
        Set-StrictMode -Version Latest

        #Import-Module -Name ..\Modules\TridentCC.Common.psd1 -MinimumVersion 1.0.0
    }
    process {

        $InformationPreference = 'Continue'

        $org = "https://dev.azure.com/$Organisation"

        $azFound = az --version

        if (-not $azFound) {
            Write-Error "You should install az cli."
            break
        }

        $extensionName = "azure-devops"
        Install-Extension $extensionName
        [Console]::ResetColor()

        $groupFrom = (az pipelines variable-group list --group-name $groupFromName --org $org --project $projectFromName -o json) | ConvertFrom-Json
        [Console]::ResetColor()

        $groupFromId = $groupFrom.id

        $varsFrom = (az pipelines variable-group variable list --group-id $groupFromId --org $org --project $projectFromName -o json) | ConvertFrom-Json | Get-ObjectMember
        [Console]::ResetColor()

        foreach ($var in $varsFrom) {

            $key = $var.Key
            $value = '{0}' -f $var.Value

            if ($key -eq $varFromName) {

                if ($var.IsSecret -eq $true) {

                    return "SECRET"
                } # end if

                return $value
            } # end if
        } # end foreach

        return $null
    }
}
