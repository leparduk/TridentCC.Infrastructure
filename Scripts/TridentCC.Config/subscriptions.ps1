using module .\subscriptions.psm1
using module .\resource.psm1

<#
    .SYNOPSIS
        This stub loads config information for subscriptions using the subscription class.
    .DESCRIPTION
        This stub loads config information for subscriptions using the subscription class. Use dot loading ti use this is a script
    .EXAMPLE
        . .\subscriptions.ps1
    .NOTES
        There should be notes.
    .LINK
        None
#>

[string]$dev = 'abcdefgh-1234-1234-1234-abcdefghijkl'
[string]$sandbox = 'abcdefgh-1234-1234-1234-abcdefghijkl'


$Subscriptions = @(

    [Subscription]::new("dev", $dev)
)

$Sandboxes = @(
    [Subscription]::new("sandbox", $sandbox)
)
