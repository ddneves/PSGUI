<#	
    .NOTES
    ===========================================================================
        Created on:   	08.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       Internal_About.ps1
    ===========================================================================
    .DESCRIPTION
        About 
#> 
#region PreFilling

#endregion


#region EventHandler

$Internal_About.Add_MouseDown(
	{
       $Internal_About.Close() 
	}
)

#endregion
