---
external help file: TridentCC.Common-help.xml
Module Name: TridentCC.Common
online version:
schema: 2.0.0
---

# Read-LibVar

## SYNOPSIS
Read a Variable from a Group in a Project.

## SYNTAX

```
Read-LibVar [-projectFromName] <String> [-groupFromName] <String> [-varFromName] <String> [<CommonParameters>]
```

## DESCRIPTION
Read a Variable from a Group in a Project.

## EXAMPLES

### EXAMPLE 1
```
read-LibVar -ProjectFromName "" -groupFromName "" -varFromName ""
```

## PARAMETERS

### -projectFromName
The Name of the Project to read from

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

### -groupFromName
The name of the Library to read from

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

### -varFromName
The name of the key to read from

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
There should be notes.

## RELATED LINKS

[There should be a link]()

