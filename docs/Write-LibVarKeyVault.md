---
external help file: TridentCC.Common-help.xml
Module Name: TridentCC.Common
online version:
schema: 2.0.0
---

# Write-LibVarKeyVault

## SYNOPSIS
Write a Variable to a Key Vault with a name based on the Project / Group / Key.

## SYNTAX

```
Write-LibVarKeyVault [-projectToName] <String> [-groupToName] <String> [-varToName] <String> [-value] <String>
 [<CommonParameters>]
```

## DESCRIPTION
We are writing the variable to tcc-uks-infra-common-kv in tcc-uks-infra-common-rg as a backup to the value in the Library

The key name in the Key Vault is the Project--Group--Key used in the library.
dots and underscores are replaced with dashes.
The inputs to this cmdlet match the inputs to write-LibVar

## EXAMPLES

### EXAMPLE 1
```
write-LibVarKeyVault -ProjectToName "" -groupToName "" -varToName "" -value ""
```

## PARAMETERS

### -projectToName
The Name of the Project to write to - forms part of the secret key

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
The name of the Library to write to - forms part of the secret key

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
The name of the key to write to - forms part of the secret key

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
There should be notes.

## RELATED LINKS

[There should be a link]()

