<#	
        .NOTES
        ===========================================================================
        Created on:   	04.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI_Manager
        Filename:       PSGUI_Manager.psm1
        ===========================================================================
        .DESCRIPTION
        Functions for PSGUI_Manager.
#> 

#===========================================================================
#region loading external functions



#endregion

#region functions

function Get-FileDialog
{
    param([string]$Title,

[string]$Directory,
[string]$Filter = 'All Files (*.*)|*.*')
    $null = [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    # UZ: replaced OpenFileDialog by SaveFileDialog
    $objForm = New-Object -TypeName System.Windows.Forms.SaveFileDialog
    $objForm.InitialDirectory = $Directory
    $objForm.Filter = $Filter
    $objForm.Title = $Title
    $Show = $objForm.ShowDialog()
    If ($Show -eq 'OK')
    {
        Return $objForm.FileName
    }
    Else 
    {
        Write-Error -Message 'Operation cancelled by user.'
    }
}

Function Get-FolderDialog

{
    param
    (
        [Object]
        $initialDirectory
    )

    [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')

    $folderName = New-Object -TypeName System.Windows.Forms.FolderBrowserDialog
      #  $folderName.RootFolder = [System.Environment+SpecialFolder]::MyComputer
    $folderName.SelectedPath = $initialDirectory
    
    if($folderName.ShowDialog() -eq 'OK')
    {
        $folder = $folderName.SelectedPath
    }
    return $folder
}

#endregion
#===========================================================================
