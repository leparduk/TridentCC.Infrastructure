---
external help file: TridentCC.Common-help.xml
Module Name: TridentCC.Common
online version: https://docs.microsoft.com/en-us/cli/azure/extension?view=azure-cli-latest
schema: 2.0.0
---

# Install-Extension

## SYNOPSIS
Validates the Installation of an extension

## SYNTAX

```
Install-Extension [-extensionName] <String> [<CommonParameters>]
```

## DESCRIPTION
The Install-Extension cmdlet checks whether an azure devops extension is installed and if not installs it

## EXAMPLES

### EXAMPLE 1
```
Install-Extension -extensionName "application-insights"
```

## PARAMETERS

### -extensionName
Name of Extension to install if not already installed

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
There should be notes.

## RELATED LINKS

[https://docs.microsoft.com/en-us/cli/azure/extension?view=azure-cli-latest](https://docs.microsoft.com/en-us/cli/azure/extension?view=azure-cli-latest)

