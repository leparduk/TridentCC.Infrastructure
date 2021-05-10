---
external help file: TridentCC.Common-help.xml
Module Name: TridentCC.Common
online version:
schema: 2.0.0
---

# Get-ResourceLocationByNameAndType

## SYNOPSIS
Gets a resource id string

## SYNTAX

```
Get-ResourceLocationByNameAndType [-ResourceGroupName] <String> [-ResourceName] <String>
 [-ResourceType] <String> [[-SubscriptionId] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-ResourceByNameAndType cmdlet binds a cert to a hostname to a web app.

## EXAMPLES

### EXAMPLE 1
```
Get-ResourceLocationByNameAndType -ResourceGroupName $ResourceGroupName -ResourceName $ResourceName -ResourceType "microsoft.operationalinsights/workspaces"
```

## PARAMETERS

### -ResourceGroupName
Name of Resource Group

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ResourceName
Name of the Resource

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ResourceType
Name of the Resource Type

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -SubscriptionId
Subscription Id if not the current one

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
There should be notes.

## RELATED LINKS

[There should be a link]()

