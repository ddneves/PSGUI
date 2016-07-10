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
  
#Binding with PSCustomObjects
[PSCustomObject]$paramList = @()
Get-Process |
Select-Object -First 20 |
ForEach-Object -Process {
    $paramList += @([PSCustomObject]@{
            Set  = if($_.Name.Length -gt 8) 
            {
                'bold'
            }
            else 
            {
                'normal'
            }
            Name = $_.Name
        }      
    )
} 

$05_Bindings2_lvEvents.ItemsSource = $paramList


#endregion


#region EventHandler
 
$05_Bindings2_btnStop.add_Click(
    {
        [System.Object]$sender = $args[0]
        [System.Windows.RoutedEventArgs]$e = $args[1]   
        $prozesse = Get-Process | Select-Object -First 6
        $05_Bindings2_cbbDienste.ItemsSource = $prozesse
        Stop-Process -Name $05_Bindings2_cbbDienste.SelectedValue.Name
    }
)


#endregion

