class Resource {
    [string]$name
    [string]$id
    [string]$subscription
    [string]$subscriptionId
    [DateTime]$createdTime

    Resource(
        [string]$name,
        [string]$id,
        [string]$subscription,
        [string]$subscriptionId,
        [DateTime]$createdTime
    ) {
        $this.name = $name
        $this.id = $id
        $this.subscription = $subscription
        $this.subscriptionId = $subscriptionId
        $this.createdTime = $createdTime
    }
}
