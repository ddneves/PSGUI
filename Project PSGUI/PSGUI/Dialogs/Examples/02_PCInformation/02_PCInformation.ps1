<#	
    .NOTES
    ===========================================================================
        Created on:   	04.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI - PSGUI_Manager
        Filename:       02_PCInformation.ps1
    ===========================================================================
    .DESCRIPTION
        Functions 
#> 
#region PreFilling
$02_PCInformation.Add_Loaded(
        {
			# WMI abrufen
			$oWMIOS = Get-WmiObject win32_OperatingSystem

			$02_PCInformation_txtHostName.Text = $oWMIOS.PSComputerName

			#Formats and displays OS name
			$02_PCInformation_aOSName = $oWMIOS.name.Split("|")
			$02_PCInformation_txtOSName.Text = $02_PCInformation_aOSName[0]

			#Formats and displays available memory
			$02_PCInformation_sAvailableMemory = [math]::round($oWMIOS.freephysicalmemory/1000,0)
			$02_PCInformation_sAvailableMemory = "$02_PCInformation_sAvailableMemory MB"
			$02_PCInformation_txtAvailableMemory.Text = $02_PCInformation_sAvailableMemory

			#Displays OS Architecture
			$02_PCInformation_txtOSArchitecture.Text = $oWMIOS.OSArchitecture

			#Displays Windows Directory
			$02_PCInformation_txtWindowsDirectory.Text = $oWMIOS.WindowsDirectory

			#Displays Version
			$02_PCInformation_txtWindowsVersion.Text = $oWMIOS.Version

			#Displays System Drive
			$02_PCInformation_txtSystemDrive.Text = $oWMIOS.SystemDrive      
    }
)
#endregion

#region EventHandler

$02_PCInformation_btnExit.Add_Click({$02_PCInformation.Close()})

#endregion


