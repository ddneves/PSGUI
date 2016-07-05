<#	
    .NOTES
    ===========================================================================
        Created on:   	05.07.2016
        Created by:   	David das Neves
        Version:        0.2
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
        [Parameter(Mandatory=$false, Position=1)]
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
        $DialogPath 
    )

    Begin
    {
        if ($DialogPath -and (-not $DialogName))
        {
            $DialogName = $DialogPath.Split('\')[-1]
        }    
    }
    Process
    {     
        $InternalDialogs = Get-XAMLDialogsByCategory -Category Internal
        $ProductionDialogs = Get-XAMLDialogsByCategory -Category Production
        $ExampleDialogs = Get-XAMLDialogsByCategory -Category Examples

        if ($DialogName -in $InternalDialogs)
        {
            $DialogPath = "$Internal_DialogFolder\$DialogName"  
        }
        elseif ($DialogName -in $ProductionDialogs)
        {
            $DialogPath = "$Production_DialogFolder\$DialogName"  
        }        
        elseif ($DialogName -in $ExampleDialogs)
        {
            $DialogPath = "$Examples_DialogFolder\$DialogName"  
        }

        #Loads XAML
        Invoke-Expression -Command "Initialize-XAMLDialog -XAMLPath '$DialogPath\$DialogName.xaml'"
                
        #Loads event and scriptcode
        if (Get-Item "$DialogPath\$DialogName.ps1"       )
        {
            . "$DialogPath\$DialogName.ps1" 
        }    
        
        #Loads functions etc.
        if (Get-Item "$DialogPath\$DialogName.psm1")
        {
          Import-Module "$DialogPath\$DialogName.psm1"       -ErrorAction Continue
        }
                  
        if (-not $OnlyCreateVariables)
        {
            if ($OpenWithOnlyShowFlag)
            {
                Invoke-Expression -Command "`$$DialogName.Show() | Out-Null" -ErrorAction Continue
            }
            else
            {
                Invoke-Expression -Command "`$$DialogName.Dispatcher.InvokeAsync{ `$$DialogName.ShowDialog() }.Wait()" -ErrorAction Continue
            }    
        }        
    }
    End
    {
    }
}
