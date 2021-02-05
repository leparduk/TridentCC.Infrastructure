function Get-ResourceByName {
    <#
    .SYNOPSIS
        Gets a resource id string
    .DESCRIPTION
        The Get-ResourceByNameAndType cmdlet binds a cert to a hostname to a web app.
    .PARAMETER ResourceGroupName
        Name of Resource Group
    .PARAMETER ResourceName
        Name of the Resource
    .PARAMETER SubscriptionId
        Subscription Id if not the current one
    .EXAMPLE
        Get-ResourceByName -ResourceGroupName $ResourceGroupName -ResourceName $ResourceName
    .NOTES
        There should be notes.
    .LINK
        https://docs.microsoft.com/en-us/cli/azure/resource?view=azure-cli-latest#az-resource-show
#>
    [CmdletBinding()]
    [OutputType([System.String])]
    Param(
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [string] $ResourceGroupName,
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [string] $ResourceName,
        [string] $SubscriptionId
    )
    begin {
        Set-StrictMode -Version Latest
    }
    process {

        $InformationPreference = 'Continue'

        if ([string]::IsNullOrEmpty($SubscriptionId)) {

            $resources = @(az resource list -g $ResourceGroupName --query "[?name=='$ResourceName']" -o json | convertfrom-json)

        }
        else {

            $resources = @(az resource list -g $ResourceGroupName --query "[?name=='$ResourceName']"  --subscription $SubscriptionId -o json | convertfrom-json)
        }

        if ($resources.Count -eq 1) {

            return $resources[0].id

        }
        elseif ($resources.Count -eq 0) {

            Write-Error "No matching Resource Found: $ResourceName"
        }
        else {

            Write-Error "More than one matching Resource Found: $ResourceName"
        }
    }
}
