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
 
#Binding by Memberpath
$04_Bindings1_cbbDienste.DisplayMemberPath = 'Name'
$04_Bindings1_cbbDienste.ItemsSource = $prozesse
$04_Bindings1_cbbDienste.SelectedIndex = 0

#endregion


#region EventHandler

$04_Bindings1_btnStop.add_Click(
    {
        [System.Object]$sender = $args[0]
        [System.Windows.RoutedEventArgs]$e = $args[1]   
        $prozesse = Get-Process | Select-Object -First 6
        $04_Bindings1_cbbDienste.ItemsSource = $prozesse
        Stop-Process -Name $04_Bindings1_cbbDienste.SelectedValue.Name
    }
)


#endregion

