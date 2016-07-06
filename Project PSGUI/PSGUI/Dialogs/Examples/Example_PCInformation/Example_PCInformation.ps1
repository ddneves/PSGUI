<#	
    .NOTES
    ===========================================================================
        Created on:   	04.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI - PSGUI_Manager
        Filename:       Example_PCInformation.ps1
    ===========================================================================
    .DESCRIPTION
        Functions 
#> 
#region PreFilling
$Example_PCInformation.Add_Loaded(
        {
			# WMI abrufen
			$oWMIOS = Get-WmiObject win32_OperatingSystem

			$Example_PCInformation_txtHostName.Text = $oWMIOS.PSComputerName

			#Formats and displays OS name
			$Example_PCInformation_aOSName = $oWMIOS.name.Split("|")
			$Example_PCInformation_txtOSName.Text = $Example_PCInformation_aOSName[0]

			#Formats and displays available memory
			$Example_PCInformation_sAvailableMemory = [math]::round($oWMIOS.freephysicalmemory/1000,0)
			$Example_PCInformation_sAvailableMemory = "$Example_PCInformation_sAvailableMemory MB"
			$Example_PCInformation_txtAvailableMemory.Text = $Example_PCInformation_sAvailableMemory

			#Displays OS Architecture
			$Example_PCInformation_txtOSArchitecture.Text = $oWMIOS.OSArchitecture

			#Displays Windows Directory
			$Example_PCInformation_txtWindowsDirectory.Text = $oWMIOS.WindowsDirectory

			#Displays Version
			$Example_PCInformation_txtWindowsVersion.Text = $oWMIOS.Version

			#Displays System Drive
			$Example_PCInformation_txtSystemDrive.Text = $oWMIOS.SystemDrive      
    }
)
#endregion


#region EventHandler

$Example_PCInformation_btnExit.Add_Click({$Example_PCInformation.Close()})

#endregion

