---
external help file: TridentCC.Common-help.xml
Module Name: TridentCC.Common
online version: https://docs.microsoft.com/en-us/cli/azure/resource?view=azure-cli-latest#az-resource-show
schema: 2.0.0
---

# Get-ResourceByName

## SYNOPSIS
Gets a resource id string

## SYNTAX

```
Get-ResourceByName [-ResourceGroupName] <String> [-ResourceName] <String> [[-SubscriptionId] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-ResourceByNameAndType cmdlet binds a cert to a hostname to a web app.

## EXAMPLES

### EXAMPLE 1
```
Get-ResourceByName -ResourceGroupName $ResourceGroupName -ResourceName $ResourceName
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

### -SubscriptionId
Subscription Id if not the current one

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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

[https://docs.microsoft.com/en-us/cli/azure/resource?view=azure-cli-latest#az-resource-show](https://docs.microsoft.com/en-us/cli/azure/resource?view=azure-cli-latest#az-resource-show)

