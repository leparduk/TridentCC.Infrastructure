---
external help file: TridentCC.Common-help.xml
Module Name: TridentCC.Common
online version:
schema: 2.0.0
---

# Write-LibVar

## SYNOPSIS
Write a Variable to a Group in a Projects.

## SYNTAX

```
Write-LibVar [-projectToName] <String> [-groupToName] <String> [-varToName] <String> [-value] <String>
 [[-IsSecret] <Boolean>] [-Demo] [<CommonParameters>]
```

## DESCRIPTION
Write a Variable to a Group in a Projects.

## EXAMPLES

### EXAMPLE 1
```
write-LibVar -ProjectToName "" -groupToName "" -varToName "" -value ""
```

## PARAMETERS

### -projectToName
The Name of the Project to write to

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

### -groupToName
The name of the Library to write to

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

### -varToName
The name of the key to write to

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

### -value
The value

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -IsSecret
Flag field to display help.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Demo
Replace this with WhatIf Functionality

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

