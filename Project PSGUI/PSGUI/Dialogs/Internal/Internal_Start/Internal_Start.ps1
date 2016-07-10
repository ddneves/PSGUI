<#	
    .NOTES
    ===========================================================================
        Created on:   	08.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       Internal_Start.ps1
    ===========================================================================
    .DESCRIPTION
        About 
#> 
#region PreFilling
$Internal_Start.Add_Activated(
	{
       $Internal_Start.Dispatcher.Invoke([action]{},'Render')
       Start-Sleep -Milliseconds 1000 
       $Internal_Start.Close() 
	}
)
#endregion


#region EventHandler

#endregion

