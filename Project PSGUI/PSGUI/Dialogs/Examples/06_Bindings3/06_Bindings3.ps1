<#	
    .NOTES
    ===========================================================================
        Created on:   	
        Created by:   	
        Version:        
        Project:        
        Filename:       .ps1
    ===========================================================================
    .DESCRIPTION
        Functions 
#> 
#region PreFilling


$prozesse = Get-Process | Select-Object -First 20
 
#Binding with setup bindinds in xaml file
$06_Binding3_lvVariables.ItemsSource = $prozesse

#endregion


#region EventHandler


$06_Binding3_btnStop.add_Click(
    {
        [System.Object]$sender = $args[0]
        [System.Windows.RoutedEventArgs]$e = $args[1]   
        $prozesse = Get-Process | Select-Object -First 6
        $06_Binding3_cbbDienste.ItemsSource = $prozesse
        Stop-Process -Name $06_Binding3_cbbDienste.SelectedValue.Name
    }
)
 

#endregion

