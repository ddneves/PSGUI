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


#region EventHandler



#endregion


$08_AddColumntoListviewwithnewBinding.Add_Loaded(
	{
#Binding with PSCustomObjects
[PSCustomObject]$paramList = @()
Get-Process |Select-Object -First 20 | ForEach-Object {
    $paramList+= @([PSCustomObject]@{
            Set = if($_.Name.Length -gt 8) {   'bold' } else { 'normal' }
            Name = $_.Name                  
        }      
    )
} 
 
$08_AddColumntoListviewwithnewBinding_lvEvents.ItemsSource=$paramList

#new Column
$column = New-Object -TypeName System.Windows.Controls.GridViewColumn 
$column.Header ='Test'

#new Bindingr
$newBinding = New-Object -TypeName System.Windows.Data.Binding
$newBinding.Path = 'Set'

#Set DisplayMemberBinding
$column.DisplayMemberBinding = $newBinding

#Add column to listview
$08_AddColumntoListviewwithnewBinding_lvEvents.View.Columns.Add($column)
	}
)
