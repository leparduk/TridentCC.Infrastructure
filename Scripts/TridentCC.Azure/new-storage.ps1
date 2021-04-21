<#
    .SYNOPSIS
        The new-storage cmdlet creates a storage account of the specified sku in the specified region Unlike most cmdlets location is not derived from resourcegroup.location and must be specified.
    .DESCRIPTION
        The new-storage cmdlet creates a storage account of the specified sku in the specified region Unlike most cmdlets location is not derived from resourcegroup.location and must be specified.
    .PARAMETER ResourceGroupName
        The Name of the Resource Group
    .PARAMETER storName
        The Name of the Storage Account. For convenience the name can contain dashes which the cmdlet will remove.
    .PARAMETER location
        The location, i.e. "uk south" or "uk-south". For convenience the name can contain dashes which the cmdlet will replace with a space.
    .PARAMETER sku
        The sku which defaults to "Standard_LRS" but can be "Standard_GRS" etc.
    .PARAMETER allowpubaccess
        Allow or disallow public access to all blobs or containers in the storage account which is a boolean which defaults to "False"
    .PARAMETER mintls
        The minimum TLS version to be permitted on requests to storage. default "TLS1_2"
    .EXAMPLE
        new-storage.ps1 -ResourceGroupName $ResourceGroupName -StorName $StorName -Location "UKSouth"
    .NOTES
        There should be notes.
    .LINK
        https://docs.microsoft.com/en-us/cli/azure/storage/account?view=azure-cli-latest#az-storage-account-create
#>
[cmdletbinding(SupportsShouldProcess)]
[OutputType([System.object[]])]
param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string] $ResourceGroupName,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string] $storName,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string] $location,

    [string] $sku,
    [bool] $allowpubaccess,
    [string] $minTLS
)
begin {
    Set-StrictMode -Version Latest
}
process {

    $storname = $storname.ToLowerInvariant().Replace("-", "")
    $location = $location.Replace("-", " ")

    $LRSexists = az storage account show -n $storname

    if ($null -eq $LRSexists) {

        if ([string]::IsNullOrEmpty($sku)) {
            $sku = "Standard_LRS"
        }  # end if
        if ([string]::IsNullOrEmpty($mintls)) {
            $mintls = "TLS1_2"
        } # end if

        if ($PSCmdlet.ShouldProcess($name)) {
            az storage account create -g $resourcegroupname -n $storname -l "$($location)" --sku $sku --allow-blob-public-access $allowpubaccess --min-tls-version $mintls
        }
        else {
            Write-Information -MessageData "az storage account create -g $resourcegroupname -n $storname -l \"$($location)\" --sku $sku --allow-blob-public-access $allowpubaccess --min-tls-version $mintls"
        }
    } # end if

    if (-not [string]::IsNullOrEmpty($mintls)) {

        if ($PSCmdlet.ShouldProcess($name)) {
            az storage account update -g $resourcegroupname -n $storname --min-tls-version $mintls
        }
        else {
            Write-Information -MessageData "az storage account update -g $resourcegroupname -n $storname --min-tls-version $mintls"
        } # end if

    } # end if

    if (-not [string]::IsNullOrEmpty($allowpubaccess)) {

        if ($PSCmdlet.ShouldProcess($name)) {
            az storage account update -g $resourcegroupname -n $storname --allow-blob-public-access $allowpubaccess
        }
        else {
            Write-Information -MessageData "az storage account update -g $resourcegroupname -n $storname --allow-blob-public-access $allowpubaccess"
        } # end if
    } # end if
}
