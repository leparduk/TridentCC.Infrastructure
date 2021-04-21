<#
    .SYNOPSIS
        This extensioons method is used to extract properies from a PSObject and present them as an array.
    .DESCRIPTION
        This extensioons method is used to extract properies from a PSObject and present them as an array.
    .EXAMPLE
        . .\GetPropByPath.ps1
    .NOTES
        There should be notes.
    .LINK
        None
#>

try {
    $exists = ((Get-TypeData System.Management.Automation.PSCustomObject).Members.Keys -match "GetPropByPath")
}
catch {
    $exists = $null
}

if (-not ($exists -eq 'GetPropByPath')) {

    Write-Output 'Loaded GetProp By Path'

    'System.Management.Automation.PSCustomObject',
    'Deserialized.System.Management.Automation.PSCustomObject' |
    Update-TypeData -TypeName { $_ } `
        -MemberType ScriptMethod -MemberName GetPropByPath -Value { #`
        param($propPath)
        $obj = $this
        foreach ($prop in $propPath -split '\.') {
            # See if the property spec has an index (e.g., 'foo[3]')
            if ($prop -match '(.+?)\[(.+?)\]$') {
                $obj = $obj.($Matches.1)[$Matches.2]
            }
            else {
                $obj = $obj.$prop
            }
        }
        # Output: If the value is a collection (array), output it as a
        #         *single* object.
        if ($obj.Count) {
            , $obj
        }
        else {
            $obj
        }
    }
}
