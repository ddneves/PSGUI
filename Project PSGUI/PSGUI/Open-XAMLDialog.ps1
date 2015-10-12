<#	
    .NOTES
    ===========================================================================
        Created on:   	04.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       Open-XAMLDialog.ps1
    ===========================================================================
    .DESCRIPTION
        Function from the PSGUI module.
#> 
function Open-XAMLDialog
{
    <#
        .Synopsis
        Opens the dialog.
        .DESCRIPTION
        Loads dialog with xaml, events and code and shows it up as a dialog.
        .EXAMPLE
        Open-XAMLDialog "MyForm"
    #>
    [CmdletBinding()]
    Param
    (
        #Name of the dialog
        [Parameter(Mandatory=$true, Position=1)]
        [Alias('Name')] 
        $DialogName,

        #Switch for creating only the global variables
        #which can be used to develop specific functions with intellisense.
        #It will be very helpful to generate the functions in the events.
        [switch]
        $OnlyCreateVariables = $false,

        #Switch for showing with show flag.
        #For use if a window open another window and shall be reactive.
        #Otherwise the window will be opened as Showdialog.
        [switch]
        $OpenWithOnlyShowFlag = $false,

        #Path of the dialog
        [Parameter(Mandatory=$false)]
        [Alias('Path')] 
        $DialogPath = "Dialogs\$DialogName"
    )

    Begin
    {
    }
    Process
    {        
        if ($DialogName -like 'Internal_*')
        {
            $DialogPath = "$Internal_DialogFolder\$DialogName"  
        }

        #Loads xaml
        Invoke-Expression -Command "Initialize-XAMLDialog -XAMLPath '$DialogPath\$DialogName.xaml'"
                
        #Loads event and scriptcode
        . "$DialogPath\$DialogName.ps1"       
        
        #Loads functions etc.
        Get-Item "$DialogPath\$DialogName.psm1" | Import-Module -Verbose
        #. "$DialogPath\$DialogName.psm1"
                  
        if (-not $OnlyCreateVariables)
        {
            if ($OpenWithOnlyShowFlag)
            {
                Invoke-Expression -Command "`$$DialogName.Show() | Out-Null" -ErrorAction Continue
            }
            else
            {
                Invoke-Expression -Command "`$$DialogName.ShowDialog() | Out-Null" -ErrorAction Continue
            }            
        }        
    }
    End
    {
    }
}