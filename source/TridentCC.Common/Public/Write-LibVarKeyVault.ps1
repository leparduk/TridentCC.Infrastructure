function Write-LibVarKeyVault {
    <#
    .SYNOPSIS
        Write a Variable to a Key Vault with a name based on the Project / Group / Key.
    .DESCRIPTION
        We are writing the variable to tcc-uks-infra-common-kv in tcc-uks-infra-common-rg as a backup to the value in the Library

        The key name in the Key Vault is the Project--Group--Key used in the library. dots and underscores are replaced with dashes.
        The inputs to this cmdlet match the inputs to write-LibVar
    .PARAMETER projectToName
        The Name of the Project to write to - forms part of the secret key
    .PARAMETER groupToName
        The name of the Library to write to - forms part of the secret key
    .PARAMETER varToName
        The name of the key to write to - forms part of the secret key
    .PARAMETER value
        The value
    .EXAMPLE
        write-LibVarKeyVault -ProjectToName "" -groupToName "" -varToName "" -value ""
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
        [string] $value
    )
    begin {
        Set-StrictMode -Version Latest
    }
    process {

        $InformationPreference = 'Continue'

        $vaultName = "tcc-uks-infra-common-kv"
        $subscription = "12345678-abcd-efgh-ijkl-1234abcd5678"

        $name = "$($projectToName)--$($groupToName)--$($varToName)"
        $name = $name.Replace('.', '-') # secret names can only contain alpahnumeric and dashes
        $name = $name.Replace('_', '-')
        $name

        $current = az keyvault secret show --vault-name $vaultName --subscription $subscription --name $name

        if ([string]::IsNullOrEmpty($current)) {

            Write-Information "Old Value=NULL"

            az keyvault secret set --vault-name $vaultName --subscription $subscription --name $name --value $value

            Write-Information "New Value='$($value)'"
        }
        else {

            $converted = $current | ConvertFrom-Json

            if ($converted.value -ne $value) {

                Write-Information "Old Value='$($converted.value)'"

                az keyvault secret set --vault-name $vaultName --subscription $subscription --name $name --value $value

                Write-Information "New Value='$($value)'"
            }
            else {

                Write-Information "Unchanged"
            } # end if
        }  # end if
    }

}

