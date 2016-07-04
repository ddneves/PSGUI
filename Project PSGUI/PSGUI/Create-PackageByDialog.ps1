<#	
    .NOTES
    ===========================================================================
        Created on:   	11.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       Create-PackageByDialog.ps1
    ===========================================================================
    .DESCRIPTION
        Function from the PSGUI module.
#> 
function Create-PackageByDialog
{
    <#
        .Synopsis
        Renames a dialog and its containing functions.        
        .EXAMPLE
        Rename-XAMLDialog
    #>
    [CmdletBinding()]
    Param
    (
        #Name of the dialog
        [Parameter(Mandatory=$true, Position=1)]
        [Alias('Name')] 
        $DialogName,

        #Name of the dialog
        [Parameter(Mandatory=$true, Position=2)]
        [Alias('Path')] 
        $DialogPath,
         
        #new Name of the dialog
        [Parameter(Mandatory=$false, Position=3)]
        $OutputPath = "$env:UserProfile\Documents\WindowsPowerShell\GUI_Manager\Package\",

        [Parameter(Mandatory=$false, Position=4)]
        $OutputName = "Install_PSGUI_Dialog"
    )

    Begin
    {
         Add-Type -AssemblyName System.IO.Compression.FileSystem
    }
    Process
    {
        #Proving if GUI-Manager is also installed - either this function cannot be executed due to missing files
        if (-not (Test-Path -Path "$env:UserProfile\Documents\WindowsPowerShell\GUI_Manager"))
        {
            Write-Error 'GUI-Manager is not installed. This Function cannot be executed without the GUI-Manager'
            return
        } 

        #region creating folder structure for using computer
            #$OutputPath= "$env:UserProfile\Documents\WindowsPowerShell\GUI_Manager\Package\"

            $tempPKGFolder="$env:TEMP\PSGUI"
            Copy-Item "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI\" $tempPKGFolder -Recurse -Force
            Copy-Item $DialogPath "$tempPKGFolder\Dialogs" -Force
        #endregion
         
        #region zipping 
            $Target = [System.IO.Path]::Combine($OutputPath,"PSGUI.zip")
            
            $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
 
            # compress complete folder to ZIP file
            if (Test-Path $Target)
            {
                Remove-Item $Target -force
            }
            [System.IO.Compression.ZipFile]::CreateFromDirectory($tempPKGFolder, $Target, $compressionLevel, $True) 
        #endregion

        #region creating the installationfile
            $sedFile = "$env:UserProfile\Documents\WindowsPowerShell\GUI_Manager\Package\install.sed"

            #Replacing variables
            $sedContent = (Get-Content $sedFile).Replace('#InstallationFolder#',$OutputPath)
            $sedContent = $sedContent.Replace('#SourceFilesInstallationFolder#',$OutputPath)        
            $sedContent = $sedContent.Replace('#ExecName#',$OutputName)   

            #Writing config-file to new file
            Set-Content -Value $sedContent -Path "$env:UserProfile\Documents\WindowsPowerShell\GUI_Manager\Package\installpkg.sed" -Force

            #executing installer creation with config file
            Invoke-Expression -command "iexpress /N /Q /M $env:UserProfile\Documents\WindowsPowerShell\GUI_Manager\Package\installpkg.sed"
        #endregion
    }
    End
    {
        #region cleanup
            if (Test-Path -Path $tempPKGFolder)
            {
                Remove-Item $tempPKGFolder -Recurse -Force   
            }
            if (Test-Path -Path $Target)
            {
               # Remove-Item $Target -Recurse -Force        
            }
        #endregion

        #waiting for file cration
        Start-Sleep -Seconds 1

        #opening file in explorer
        $openPath= "$OutputPath$OutputName.exe"
        Invoke-Expression "explorer '/select,$openPath'"
    }
}

#Test
Create-PackageByDialog -DialogName 'clean' -Dialogpath 'C:\OneDrive\_Projekte\PS\PSGUI\Project PSGUI\GUI_Manager\Dialogs\Clean' -OutputName MyDialog