
function Write-LibVar {
    <#
    .SYNOPSIS
        Write a Variable to a Group in a Projects.
    .DESCRIPTION
        Write a Variable to a Group in a Projects.
    .PARAMETER projectToName
        The Name of the Project to write to
    .PARAMETER groupToName
        The name of the Library to write to
    .PARAMETER varToName
        The name of the key to write to
    .PARAMETER value
        The value
     .PARAMETER IsSecret
        Flag field to display help.
     .PARAMETER Demo
        Replace this with WhatIf Functionality
    .EXAMPLE
        write-LibVar -ProjectToName "" -groupToName "" -varToName "" -value ""
    .NOTES
        There should be notes.
    .LINK
        There should be a link
#>
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $projectToName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $groupToName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $varToName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $value,
        [bool]   $IsSecret,

        [Switch] $Demo # Flag to show intended actions without performing them
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

        # Create If Not Exists?
        $groupTo = (az pipelines variable-group list --group-name $groupToName --org $org --project $projectToName -o json) | ConvertFrom-Json
        [Console]::ResetColor()

        if ([string]::IsNullOrEmpty($groupTo)) {
            Write-Information "Creating Group - $groupToName"
            if (-not $Demo) {
                $timestamp = (Get-Date).ToString("yyyy_MM_dd HH_mm")
                az pipelines variable-group create --name $groupToName --org $org --project $projectToName --variables Created=$timestamp -o json
                $groupTo = (az pipelines variable-group list --group-name $groupToName --org $org --project $projectToName -o json) | ConvertFrom-Json
                [Console]::ResetColor()
            } # end if
        } # end if

        $groupToId = $groupTo.id

        $varsTo = (az pipelines variable-group variable list --group-id $groupToId --org $org --project $projectToName -o json) | ConvertFrom-Json | Get-ObjectMember
        [Console]::ResetColor()

        $found = $false

        foreach ($var in $varsTo) {

            #Write-Information "========="
            #Write-Information $var

            $key = $var.Key
            $current = '"{0}"' -f $var.Value

            if ($key -eq $varToName) {

                #Write-Information $current
                #Write-Information $value

                # values from devops libs come back as quoted strings so we wrap the input as "value" for the comparison
                if ($current -ne """$($value)""") {
                    az pipelines variable-group variable update --group-id $groupToId --org $org --project $projectToName --name $varToName --value $value
                }

                $found = $true

                break
            } # end if
        } # end foreach

        if (-not $found) {

            if ($IsSecret) {

                Write-Information "Create SECRET - varTo $key does not exist"
                az pipelines variable-group variable create --group-id $groupToId --org $org --project $projectToName --name $varToName --value $value --secret true

                [Console]::ResetColor()

            }
            else {

                Write-Information "Create - varTo $key does not exist"
                az pipelines variable-group variable create --group-id $groupToId --org $org --project $projectToName --name $varToName --value $value

                [Console]::ResetColor()
            } # end if
        } # end if
    }
}

