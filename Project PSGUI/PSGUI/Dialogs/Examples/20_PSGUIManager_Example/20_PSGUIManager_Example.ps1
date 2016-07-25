#requires -Version 3 -Modules PSGUI
<#	
        .NOTES
        ===========================================================================
        Created on:   	05.07.2016
        Created by:   	David das Neves
        Version:        0.43
        Project:        20_PSGUIManager_Example
        Filename:       20_PSGUIManager_Example.ps1
        ===========================================================================
        .DESCRIPTION
        Code-Behind for PSGUI-Manager.
#> 

#===========================================================================
#region functions

#endregion
#===========================================================================

#===========================================================================
#region PreFilling

$20_PSGUIManager_Example.Add_Loaded(
    {
        $AllDialogsPaths = Get-ChildItem -Path "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI\Dialogs\" -Directory

        $20_PSGUIManager_Example_cbDialogFolders.ItemsSource = $AllDialogsPaths
                
        foreach ($DialogFolder in ($20_PSGUIManager_Example_cbDialogFolders.Items))
        {
            if ($DialogFolder.Name -like 'Examples')
            {
                $20_PSGUIManager_Example_cbDialogFolders.SelectedItem = $DialogFolder
                break
            }
        }
    }
)

$20_PSGUIManager_Example.Add_Closed(
    {
        foreach ($item in $20_PSGUIManager_Example_lvDialogs.Items.Name)
        {
            Get-Variable -Name "$item*" | Clear-Variable -Scope global -ErrorAction SilentlyContinue -Force
            Get-Variable -Name "$item*" | Remove-Variable -Scope global -Force -ErrorAction SilentlyContinue
        }
        Get-Variable -Name 20_PSGUIManager_Example* | Clear-Variable -Scope global -Force -ErrorAction SilentlyContinue
        Get-Variable -Name 20_PSGUIManager_Example* | Remove-Variable -Scope global -Force -ErrorAction SilentlyContinue
    }
)

$20_PSGUIManager_Example.Add_PreviewKeyDown(
    {
        if(([System.Windows.Input.Keyboard]::IsKeyDown('Ctrl') -eq $true) -and $_.Key -eq 'S') 
        {
            $20_PSGUIManager_Example_miSave.RaiseEvent((New-Object -TypeName System.Windows.RoutedEventArgs -ArgumentList $([System.Windows.Controls.MenuItem]::ClickEvent)))
        }
        if(([System.Windows.Input.Keyboard]::IsKeyDown('Ctrl') -eq $true) -and $_.Key -eq 'R') 
        {
            $20_PSGUIManager_Example_miRenderDialog.RaiseEvent((New-Object -TypeName System.Windows.RoutedEventArgs -ArgumentList $([System.Windows.Controls.MenuItem]::ClickEvent)))
        }
    }
)

#endregion
#===========================================================================


#===========================================================================
#region EventHandler

#===========================================================================
#region MenuItems
$20_PSGUIManager_Example_miQuit.Add_Click(
    {
        $20_PSGUIManager_Example.Close()
    }
)

$20_PSGUIManager_Example_miAbout.Add_Click(
    {
        Open-XAMLDialog -DialogName ('Internal_About')
    }
)                      
    
#endregion
#===========================================================================

#===========================================================================
#region ButtonClicks

$20_PSGUIManager_Example_cbDialogFolders.Add_SelectionChanged(
    {        
        [void]$20_PSGUIManager_Example_lvDialogs.Items.Clear()
        Get-ChildItem $($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname -Directory | ForEach-Object -Process { 
            $param = [PSCustomObject]@{
                Name = $_.Name
            }             
            [void] $20_PSGUIManager_Example_lvDialogs.Items.Add($param)
            $20_PSGUIManager_Example.Activate()            
        }
    }
)


$20_PSGUIManager_Example_miOpen.Add_Click(
    {
        Open-XAMLDialog -DialogName ('Internal_UserInput') 
        if ($Returnvalue_Internal_UserInput)
        {     
            $20_PSGUIManager_Example_DialogFolder = "$Returnvalue_Internal_UserInput"
            $20_PSGUIManager_Example_lvDialogs.Items.Clear()
            Get-ChildItem $($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname -Directory | ForEach-Object -Process { 
                $param = [PSCustomObject]@{
                    Name = $_.Name
                } 
                $20_PSGUIManager_Example_lvDialogs.Items.Add($param)   
            }                
        }
    }
)
$20_PSGUIManager_Example_miOpenPath.Add_Click(
    {
        Open-XAMLDialog -DialogName ('Internal_UserInput') 
        if ($Returnvalue_Internal_UserInput)
        {     
            $20_PSGUIManager_Example_DialogFolder = "$Returnvalue_Internal_UserInput"
            $20_PSGUIManager_Example_lvDialogs.Items.Clear()
            Get-ChildItem $($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname -Directory | ForEach-Object -Process { 
                $param = [PSCustomObject]@{
                    Name = $_.Name
                } 
                $20_PSGUIManager_Example_lvDialogs.Items.Add($param)   
            }                
        }
    }
)
$20_PSGUIManager_Example_miNewDialog.Add_Click(
    {
        Open-XAMLDialog -DialogName ('Internal_UserInput') 
        if ($Returnvalue_Internal_UserInput)
        {     
            New-XAMLDialog -DialogName $Returnvalue_Internal_UserInput -DialogPath $($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname
            $20_PSGUIManager_Example_lvDialogs.Items.Clear()
            Get-ChildItem $($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname -Directory | ForEach-Object -Process { 
                $param = [PSCustomObject]@{
                    Name = $_.Name
                } 
                $20_PSGUIManager_Example_lvDialogs.Items.Add($param)   
            }    
        }
    }
)

$20_PSGUIManager_Example_miRenameDialog.Add_Click(
    {
        Open-XAMLDialog -DialogName ('Internal_UserInput')  
        if ($Returnvalue_Internal_UserInput)
        {     
            Rename-XAMLDialog -DialogName ($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name) -DialogPath $($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname -NewDialogName $Returnvalue_Internal_UserInput

            $20_PSGUIManager_Example_lvDialogs.Items.Clear()
            Get-ChildItem $($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname -Directory | ForEach-Object -Process { 
                $param = [PSCustomObject]@{
                    Name = $_.Name
                } 
                $20_PSGUIManager_Example_lvDialogs.Items.Add($param)
            }
        }
    }
)

$20_PSGUIManager_Example_miDeleteDialog.Add_Click(
    {
        Open-XAMLDialog -DialogName ('Internal_AskIfSureInput')  

        Rename-XAMLDialog -DialogName ($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name) -DialogPath $($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname -NewDialogName $Returnvalue_Internal_UserInput

        $20_PSGUIManager_Example_lvDialogs.Items.Clear()
        Get-ChildItem $($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname -Directory | ForEach-Object -Process { 
            $param = [PSCustomObject]@{
                Name = $_.Name
            } 
            $20_PSGUIManager_Example_lvDialogs.Items.Add($param)        
        }
    }
)

#ButtonClick
$20_PSGUIManager_Example_miRenderDialog.Add_Click(
    {
        if ($20_PSGUIManager_Example_lvDialogs.SelectedValue)
        {
            Get-Variable -Name "$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)*" | Clear-Variable -Scope global
            Get-Variable -Name "$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)*" | Remove-Variable -Scope global
            Open-XAMLDialog -DialogName ($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name) -DialogPath ([System.IO.Path]::Combine($($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname,$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name))) -OpenWithOnlyShowFlag
        } 
    }
)

$20_PSGUIManager_Example_miDebug.Add_Click(
    {        
        #new file for debugging code line
        #Set-Content "C:\Temp\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)_Debug.ps1" '# Debugging lines' 
        #Add-Content "C:\Temp\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)_Debug.ps1" '# Only creating all variables for data analysis'
        #Add-Content "C:\Temp\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)_Debug.ps1" "Open-XAMLDialog -DialogName $($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name) -OnlyCreateVariables"
        #Add-Content "C:\Temp\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)_Debug.ps1" '# Show dialog in debug mode - breakpoints must be set before starting the GUI'
        #Add-Content "C:\Temp\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)_Debug.ps1"  "Open-XAMLDialog -DialogName $($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)" 
        #C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe -File  "$($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name).ps1","$($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name).psm1","C:\Temp\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)_Debug.ps1"
        C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe -File  "$($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name).ps1","$($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name).psm1","$($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)\$($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name)_Debug.ps1"
    }
)

$20_PSGUIManager_Example_miSave.Add_Click(
    {      
        if ($20_PSGUIManager_Example_lvDialogs.SelectedValue)
        {
            $saveToDialogName = $20_PSGUIManager_Example_lvDialogs.SelectedValue.Name
            if ($20_PSGUIManager_Example_rXAML.IsChecked)
            {
                $20_PSGUIManager_Example_tbCode.Text | Set-Content -Path ([System.IO.Path]::Combine($($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname,"$saveToDialogName\$saveToDialogName.xaml"))
            }
            if($20_PSGUIManager_Example_rCodeBehind.IsChecked)            
            {
                $20_PSGUIManager_Example_tbCode.Text | Set-Content -Path ([System.IO.Path]::Combine($($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname,"$saveToDialogName\$saveToDialogName.ps1"))
            }      
            if($20_PSGUIManager_Example_rFunctions.IsChecked)            
            {
                $20_PSGUIManager_Example_tbCode.Text | Set-Content -Path ([System.IO.Path]::Combine($($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname,"$saveToDialogName\$saveToDialogName.psm1"))
            }
            Initialize-XAMLDialog -XAMLPath ([System.IO.Path]::Combine($($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname,"$saveToDialogName\$saveToDialogName.xaml"))
            $20_PSGUIManager_Example_lvVariables.Items.Clear() 
            $20_PSGUIManager_Example_lvEvents.Items.Clear()                
            
            $variables = Get-Variable -Name "$saveToDialogName*"
                      
            foreach ($var in $variables)
            {
                if ($var -and $var.Name -and $var.Value)
                {
                    $varValue = (($var.Value.ToString()).Replace('System.Windows.','')).Replace('Controls.','')
                     
                    $param = [PSCustomObject]@{
                        Name   = "$($var.Name)"
                        Objekt = "$varValue"
                    }      

                    $20_PSGUIManager_Example_lvVariables.Items.Add($param)
                }
            }   
        }                  
    }
)
#endregion
#===========================================================================

#===========================================================================
#region RadioButton-CodeSwitcher
$20_PSGUIManager_Example_rCodeBehind.Add_Checked(
    {      
        if ($20_PSGUIManager_Example_lvDialogs.SelectedValue)
        {
            $dialogName = $20_PSGUIManager_Example_lvDialogs.SelectedValue.Name
            $xaml = Get-Content -Path ([System.IO.Path]::Combine($($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname,"$dialogName\$dialogName.ps1")) -Raw -Encoding UTF8
            $20_PSGUIManager_Example_tbCode.Text = $xaml              
        }                  
    }
)

$20_PSGUIManager_Example_rXAML.Add_Checked(
    {      
        if ($20_PSGUIManager_Example_lvDialogs.SelectedValue)
        {
            $dialogName = $20_PSGUIManager_Example_lvDialogs.SelectedValue.Name
            $xaml = Get-Content -Path ([System.IO.Path]::Combine($($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname,"$dialogName\$dialogName.xaml")) -Raw -Encoding UTF8
            $20_PSGUIManager_Example_tbCode.Text = $xaml
        }                  
    }
)

$20_PSGUIManager_Example_rFunctions.Add_Checked(
    {      
        if ($20_PSGUIManager_Example_lvDialogs.SelectedValue)
        {
            $dialogName = $20_PSGUIManager_Example_lvDialogs.SelectedValue.Name
            $xaml = Get-Content -Path ([System.IO.Path]::Combine($($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname,"$dialogName\$dialogName.psm1")) -Raw -Encoding UTF8
            $20_PSGUIManager_Example_tbCode.Text = $xaml
        }              
    }
)
#endregion
#===========================================================================

#===========================================================================
#region ListViewEvents
$20_PSGUIManager_Example_lvDialogs.Add_SelectionChanged(
    {      
        if ($20_PSGUIManager_Example_lvDialogs.SelectedValue)
        {
            foreach ($item in $20_PSGUIManager_Example_lvDialogs.Items.Name)
            {
                if ($20_PSGUIManager_Example_lvDialogs.SelectedValue.Name -ne $item)
                {
                    Get-Variable -Name "$item*" | Clear-Variable -Scope Global
                    Get-Variable -Name "$item*" | Remove-Variable -Scope Global
                }                    
            }
            $dialogName = $20_PSGUIManager_Example_lvDialogs.SelectedValue.Name
            $20_PSGUIManager_Example_rXAML.IsChecked = $false
            $20_PSGUIManager_Example_rXAML.IsChecked = $true

            Initialize-XAMLDialog -XAMLPath ([System.IO.Path]::Combine($($20_PSGUIManager_Example_cbDialogFolders.SelectedItem).Fullname,"$dialogName\$dialogName.xaml")) 
            $20_PSGUIManager_Example_lvVariables.Items.Clear() 
            $20_PSGUIManager_Example_lvEvents.Items.Clear()                
            
            $variables = Get-Variable -Name "$dialogName*"
                      
            foreach ($var in $variables)
            {
                if ($var -and $var.Name -and $var.Value)
                {
                    $varValue = (($var.Value.ToString()).Replace('System.Windows.','')).Replace('Controls.','')
                     
                    $param = [PSCustomObject]@{
                        Name   = "$($var.Name)"
                        Objekt = "$varValue"
                    }      

                    $20_PSGUIManager_Example_lvVariables.Items.Add($param)
                }
            }
        }                  
    }
)

$20_PSGUIManager_Example_lvVariables.Add_SelectionChanged(
    { 
        if ($20_PSGUIManager_Example_lvVariables.SelectedValue)
        {      
            #Open the xaml file by raising the checked event      
            $20_PSGUIManager_Example_rCodeBehind.IsChecked = $false
            $20_PSGUIManager_Example_rCodeBehind.IsChecked = $true
            #Re-render
            $20_PSGUIManager_Example.Dispatcher.Invoke([action]{

            },'Render')
      
            $20_PSGUIManager_Example_lvEvents.Items.Clear()   
            $object = $20_PSGUIManager_Example_lvVariables.SelectedValue.Name 

            $Events = ($((Get-Variable -Name $object).Value).GetType()).GetEvents().Name | Sort-Object

            foreach ($Event in $Events)
            {
                $FunctionNameForEvent = "$" + $20_PSGUIManager_Example_lvVariables.SelectedValue.Name + '.Add_' + $Event
                $matches = [regex]::Matches(($20_PSGUIManager_Example_tbCode.Text).ToLower(),'(\{0})' -f $FunctionNameForEvent.ToLower())
                        
                $set = 'normal'
                if ($matches.Count -gt 0)
                {
                    $set = 'bold'
                }

                $param = [PSCustomObject]@{
                    Set  = $set
                    Name = "$Event"
                }      
            
                $20_PSGUIManager_Example_lvEvents.Items.Add($param)               
            } 
            $20_PSGUIManager_Example_lvEvents.ScrollIntoView($20_PSGUIManager_Example_lvEvents.Items[0])       
        }
    }
)

$20_PSGUIManager_Example_lvEvents.Add_MouseDoubleClick(
    { 
        if ($20_PSGUIManager_Example_lvEvents.SelectedValue)
        {            
            #prove if the event handler exists
            $FunctionNameForEvent = "$" + $20_PSGUIManager_Example_lvVariables.SelectedValue.Name + '.Add_' + $20_PSGUIManager_Example_lvEvents.SelectedValue.Name
            
            #Open the xaml file by raising the checked event      
            $20_PSGUIManager_Example_rCodeBehind.IsChecked = $false
            $20_PSGUIManager_Example_rCodeBehind.IsChecked = $true
            #Re-render
            $20_PSGUIManager_Example.Dispatcher.Invoke([action]{

            },'Render')

            $newLine = [Environment]::NewLine
            $tab = "`t"
            $matches = [regex]::Matches(($20_PSGUIManager_Example_tbCode.Text).ToLower(),'(\{0})' -f $FunctionNameForEvent.ToLower())

            if ($matches.Count -eq 0)
            {
                $20_PSGUIManager_Example_tbCode.Text = "$($20_PSGUIManager_Example_tbCode.Text)$newLine$newLine$FunctionNameForEvent($newLine$tab{$newLine$newLine$tab}$newLine)"
                $20_PSGUIManager_Example_tbCode.ScrollToEnd()
            }
            else
            {              
                $20_PSGUIManager_Example_tbCode.ScrollToLine([Math]::Round(($20_PSGUIManager_Example_tbCode.Text.Substring(0,$matches[0].Index)).Split($newLine).Count/2 - 1))
                $20_PSGUIManager_Example.Dispatcher.Invoke([action]{

                },'Render')
            }
        }
    }
)
#endregion
#===========================================================================

#endregion
#===========================================================================





