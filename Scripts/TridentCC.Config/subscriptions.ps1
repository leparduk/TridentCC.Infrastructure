using module .\subscriptions.psm1
using module .\resource.psm1

[string]$dev = 'abcdefgh-1234-1234-1234-abcdefghijkl'
[string]$sandbox = 'abcdefgh-1234-1234-1234-abcdefghijkl'


$Subscriptions = @(

    [Subscription]::new("dev", $dev)
)

$Sandboxes = @(
    [Subscription]::new("sandbox", $sandbox)
)
