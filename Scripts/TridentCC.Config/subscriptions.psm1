class Subscription {
    [string]$name
    [string]$id

    Subscription(
        [string]$name,
        [string]$id
    ) {
        $this.name = $name
        $this.id = $id
    }
}
