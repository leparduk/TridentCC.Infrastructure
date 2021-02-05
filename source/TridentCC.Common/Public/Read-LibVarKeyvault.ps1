function Read-LibVarKeyVault {
    <#
    .SYNOPSIS
        Read a Variable from a Group in a Project.
    .DESCRIPTION
        Read a Variable from a Group in a Project.
    .PARAMETER projectFrom
        The Name of the Project to read from
    .PARAMETER groupFromName
        The name of the Library to read from
    .PARAMETER varFrom
        The name of the key to read from
    .EXAMPLE
        Read-LibVarKeyVault -ProjectFrom "" -groupFromName "" -varFrom ""
    .NOTES
        There should be notes.
    .LINK
        There should be a link
#>
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $projectFrom,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $groupFromName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string] $varFrom
    )
    begin {
        Set-StrictMode -Version Latest
    }
    process {

        $InformationPreference = 'Continue'

        $vaultName = "tcc-uks-infra-common-kv"
        $subscription = "12345678-abcd-efgh-ijkl-1234abcd5678"

        $name = "$($projectFrom)--$($groupFromName)--$($varFrom)"
        $name = $name.Replace('.', '-') # secret names can only contain alpahnumeric and dashes
        $name = $name.Replace('_', '-')

        try {
            $current = az keyvault secret show --vault-name $vaultName --subscription $subscription --name $name
        }
        catch {
            return $null
        }

        if (-not [string]::IsNullOrEmpty($current)) {

            $converted = $current | ConvertFrom-Json

            return $converted.value
        }
    }
}
