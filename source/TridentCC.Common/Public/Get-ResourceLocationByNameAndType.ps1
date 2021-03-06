function Get-ResourceLocationByNameAndType {
    <#
    .SYNOPSIS
        Gets a resource id string
    .DESCRIPTION
        The Get-ResourceByNameAndType cmdlet binds a cert to a hostname to a web app.
    .PARAMETER ResourceGroupName
        Name of Resource Group
    .PARAMETER ResourceName
        Name of the Resource
    .PARAMETER ResourceType
        Name of the Resource Type
    .PARAMETER SubscriptionId
        Subscription Id if not the current one
    .EXAMPLE
        Get-ResourceLocationByNameAndType -ResourceGroupName $ResourceGroupName -ResourceName $ResourceName -ResourceType "microsoft.operationalinsights/workspaces"
    .NOTES
        There should be notes.
    .LINK
        There should be a link
    #>
    [CmdletBinding()]
    [OutputType([System.String])]
    Param(
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [string] $ResourceGroupName,
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [string] $ResourceName,
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [string] $ResourceType,
        [string] $SubscriptionId
    )
    begin {
        Set-StrictMode -Version Latest
    }
    process {

        if ($ResourceType -eq "Microsoft.Storage/storageAccounts") {

            $ResourceName = $ResourceName.ToLowerInvariant().Replace("-", "")
        }
        elseif ($ResourceType -eq "Microsoft.Sql/Servers") {

            $ResourceName = $ResourceName.ToLowerInvariant()
        }
        else {

        }

        if ([string]::IsNullOrEmpty($SubscriptionId)) {

            ((az resource show -g $ResourceGroupName -n $ResourceName --resource-type $ResourceType -o json) | convertfrom-json).location
        }
        else {

            ((az resource show -g $ResourceGroupName -n $ResourceName --resource-type $ResourceType --subscription $SubscriptionId -o json) | convertfrom-json).location
        }
    }
}
