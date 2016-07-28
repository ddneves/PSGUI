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



#endregion

$prozesse = Get-Process | Select-Object -First 20
 
#Binding by Memberpath
$07_Bindings_Complete_cbbDienste.DisplayMemberPath = 'Name'
$07_Bindings_Complete_cbbDienste.ItemsSource = $prozesse
$07_Bindings_Complete_cbbDienste.SelectedIndex = 0
 
#Binding with setup bindinds in xaml file
$07_Bindings_Complete_lvVariables.ItemsSource = $prozesse
 
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
  
$07_Bindings_Complete_lvEvents.ItemsSource = $paramList

#region EventHandler

$07_Bindings_Complete_cbbDienste.add_SourceUpdated(
    {
        [System.Object]$sender = $args[0]
        [System.Windows.RoutedEventArgs]$e = $args[1]   
    }
)
 
 
$07_Bindings_Complete_btnStop.add_Click(
    {
        [System.Object]$sender = $args[0]
        [System.Windows.RoutedEventArgs]$e = $args[1]   
        $prozesse = Get-Process | Select-Object -First 6
        $07_Bindings_Complete_cbbDienste.ItemsSource = $prozesse
        Stop-Process -Name $07_Bindings_Complete_cbbDienste.SelectedValue.Name
    }
)


#endregion

