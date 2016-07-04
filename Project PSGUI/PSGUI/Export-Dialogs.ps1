<#	
    .NOTES
    ===========================================================================
        Created on:   	04.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       New-XAMLDialog.ps1
    ===========================================================================
    .DESCRIPTION
        Function from the PSGUI module.
#> 
function New-XAMLDialog
{
    <#
        .Synopsis
        Creates a new dialog.
        .DESCRIPTION
        New dialog with standard xaml.
        .EXAMPLE
        Create-XAMLDialog
        .EXAMPLE
        Create-XAMLDialog "MyForm"
    #>
    [CmdletBinding()]
    Param
    (
        #Name of the dialog
        [Parameter(Mandatory=$false, Position=1)]
        [Alias('Name')] 
        $DialogName = 'Clean',

        #Name of the dialog
        [Parameter(Mandatory=$false, Position=2)]
        [Alias('Path')] 
        $DialogPath = $Internal_DialogFolder
    )

    Begin
    {
    }
    Process
    {
        if (-not (Test-Path "$DialogPath\$DialogName"))
        {
            Copy-Item "$Internal_DialogFolder\Internal_Clean" "$DialogPath\$DialogName" -Recurse
            Get-ChildItem "$DialogPath\$DialogName" -Recurse -Include '*.ps*1', '*.xaml' | Rename-Item -NewName { $_.Name -replace 'Internal_Clean', $DialogName}            
        }
    }
    End
    {
    }
}