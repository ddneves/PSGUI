#requires -Version 3 -Modules PSGUI
<#	
        .NOTES
        ===========================================================================
        Created on:   	05.07.2016
        Created by:   	David das Neves
        Version:        0.2
        Project:        PSGUI_Manager
        Filename:       PSGUI_Manager.ps1
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

$PSGUI_Manager.Add_Loaded(
    {
        $AllDialogsPaths = Get-ChildItem -Path "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI\Dialogs\" -Directory

        $PSGUI_Manager_cbDialogFolders.ItemsSource = $AllDialogsPaths
                
        foreach ($DialogFolder in ($PSGUI_Manager_cbDialogFolders.Items))
        {
            if ($DialogFolder.Name -like 'Examples')
            {
                $PSGUI_Manager_cbDialogFolders.SelectedItem = $DialogFolder
                break
            }
        }
    }
)

$PSGUI_Manager.Add_Closed(
    {
        foreach ($item in $PSGUI_Manager_lvDialogs.Items.Name)
        {
            Get-Variable -Name "$item*" | Clear-Variable -Scope global -ErrorAction SilentlyContinue -Force
            Get-Variable -Name "$item*" | Remove-Variable -Scope global -Force -ErrorAction SilentlyContinue
        }
        Get-Variable -Name PSGUI_Manager* | Clear-Variable -Scope global -Force -ErrorAction SilentlyContinue
        Get-Variable -Name PSGUI_Manager* | Remove-Variable -Scope global -Force -ErrorAction SilentlyContinue
    }
)

$PSGUI_Manager.Add_PreviewKeyDown(
    {
        if(([System.Windows.Input.Keyboard]::IsKeyDown('Ctrl') -eq $true) -and $_.Key -eq 'S') 
        {
            $PSGUI_Manager_miSave.RaiseEvent((New-Object -TypeName System.Windows.RoutedEventArgs -ArgumentList $([System.Windows.Controls.MenuItem]::ClickEvent)))
        }
        if(([System.Windows.Input.Keyboard]::IsKeyDown('Ctrl') -eq $true) -and $_.Key -eq 'R') 
        {
            $PSGUI_Manager_miRenderDialog.RaiseEvent((New-Object -TypeName System.Windows.RoutedEventArgs -ArgumentList $([System.Windows.Controls.MenuItem]::ClickEvent)))
        }
    }
)

#endregion
#===========================================================================


#===========================================================================
#region EventHandler

#===========================================================================
#region MenuItems
$PSGUI_Manager_miQuit.Add_Click(
    {
        $PSGUI_Manager.Close()
    }
)

$PSGUI_Manager_miAbout.Add_Click(
    {
        Open-XAMLDialog -DialogName ('Internal_About')
    }
)                      
    
#endregion
#===========================================================================

#===========================================================================
#region ButtonClicks

$PSGUI_Manager_cbDialogFolders.Add_SelectionChanged(
    {        
        [void]$PSGUI_Manager_lvDialogs.Items.Clear()
        Get-ChildItem $($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname -Directory | ForEach-Object -Process { 
            $param = [PSCustomObject]@{
                Name = $_.Name
            }             
            [void] $PSGUI_Manager_lvDialogs.Items.Add($param)
            $PSGUI_Manager.Activate()            
        }
    }
)


$PSGUI_Manager_miOpen.Add_Click(
    {
        Open-XAMLDialog -DialogName ('Internal_UserInput') 
        if ($Returnvalue_Internal_UserInput)
        {     
            $PSGUI_Manager_DialogFolder = "$Returnvalue_Internal_UserInput"
            $PSGUI_Manager_lvDialogs.Items.Clear()
            Get-ChildItem $($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname -Directory | ForEach-Object -Process { 
                $param = [PSCustomObject]@{
                    Name = $_.Name
                } 
                $PSGUI_Manager_lvDialogs.Items.Add($param)   
            }                
        }
    }
)
$PSGUI_Manager_miOpenPath.Add_Click(
    {
        Open-XAMLDialog -DialogName ('Internal_UserInput') 
        if ($Returnvalue_Internal_UserInput)
        {     
            $PSGUI_Manager_DialogFolder = "$Returnvalue_Internal_UserInput"
            $PSGUI_Manager_lvDialogs.Items.Clear()
            Get-ChildItem $($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname -Directory | ForEach-Object -Process { 
                $param = [PSCustomObject]@{
                    Name = $_.Name
                } 
                $PSGUI_Manager_lvDialogs.Items.Add($param)   
            }                
        }
    }
)
$PSGUI_Manager_miNewDialog.Add_Click(
    {
        Open-XAMLDialog -DialogName ('Internal_UserInput') 
        if ($Returnvalue_Internal_UserInput)
        {     
            New-XAMLDialog -DialogName $Returnvalue_Internal_UserInput -DialogPath $($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname
            $PSGUI_Manager_lvDialogs.Items.Clear()
            Get-ChildItem $($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname -Directory | ForEach-Object -Process { 
                $param = [PSCustomObject]@{
                    Name = $_.Name
                } 
                $PSGUI_Manager_lvDialogs.Items.Add($param)   
            }    
        }
    }
)

$PSGUI_Manager_miRenameDialog.Add_Click(
    {
        Open-XAMLDialog -DialogName ('Internal_UserInput')  
        if ($Returnvalue_Internal_UserInput)
        {     
            Rename-XAMLDialog -DialogName ($PSGUI_Manager_lvDialogs.SelectedValue.Name) -DialogPath $($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname -NewDialogName $Returnvalue_Internal_UserInput

            $PSGUI_Manager_lvDialogs.Items.Clear()
            Get-ChildItem $($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname -Directory | ForEach-Object -Process { 
                $param = [PSCustomObject]@{
                    Name = $_.Name
                } 
                $PSGUI_Manager_lvDialogs.Items.Add($param)
            }
        }
    }
)

$PSGUI_Manager_miDeleteDialog.Add_Click(
    {
        Open-XAMLDialog -DialogName ('Internal_AskIfSureInput')  

        Rename-XAMLDialog -DialogName ($PSGUI_Manager_lvDialogs.SelectedValue.Name) -DialogPath $($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname -NewDialogName $Returnvalue_Internal_UserInput

        $PSGUI_Manager_lvDialogs.Items.Clear()
        Get-ChildItem $($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname -Directory | ForEach-Object -Process { 
            $param = [PSCustomObject]@{
                Name = $_.Name
            } 
            $PSGUI_Manager_lvDialogs.Items.Add($param)        
        }
    }
)

#ButtonClick
$PSGUI_Manager_miRenderDialog.Add_Click(
    {
        if ($PSGUI_Manager_lvDialogs.SelectedValue)
        {
            Get-Variable -Name "$($PSGUI_Manager_lvDialogs.SelectedValue.Name)*" | Clear-Variable -Scope global
            Get-Variable -Name "$($PSGUI_Manager_lvDialogs.SelectedValue.Name)*" | Remove-Variable -Scope global
            Open-XAMLDialog -DialogName ($PSGUI_Manager_lvDialogs.SelectedValue.Name) -DialogPath ([System.IO.Path]::Combine($($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname,$($PSGUI_Manager_lvDialogs.SelectedValue.Name))) -OpenWithOnlyShowFlag
        } 
    }
)

$PSGUI_Manager_miDebug.Add_Click(
    {        
        #new file for debugging code line
        #Set-Content "C:\Temp\$($PSGUI_Manager_lvDialogs.SelectedValue.Name)_Debug.ps1" '# Debugging lines' 
        #Add-Content "C:\Temp\$($PSGUI_Manager_lvDialogs.SelectedValue.Name)_Debug.ps1" '# Only creating all variables for data analysis'
        #Add-Content "C:\Temp\$($PSGUI_Manager_lvDialogs.SelectedValue.Name)_Debug.ps1" "Open-XAMLDialog -DialogName $($PSGUI_Manager_lvDialogs.SelectedValue.Name) -OnlyCreateVariables"
        #Add-Content "C:\Temp\$($PSGUI_Manager_lvDialogs.SelectedValue.Name)_Debug.ps1" '# Show dialog in debug mode - breakpoints must be set before starting the GUI'
        #Add-Content "C:\Temp\$($PSGUI_Manager_lvDialogs.SelectedValue.Name)_Debug.ps1"  "Open-XAMLDialog -DialogName $($PSGUI_Manager_lvDialogs.SelectedValue.Name)" 
        #C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe -File  "$($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname\$($PSGUI_Manager_lvDialogs.SelectedValue.Name)\$($PSGUI_Manager_lvDialogs.SelectedValue.Name).ps1","$($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname\$($PSGUI_Manager_lvDialogs.SelectedValue.Name)\$($PSGUI_Manager_lvDialogs.SelectedValue.Name).psm1","C:\Temp\$($PSGUI_Manager_lvDialogs.SelectedValue.Name)_Debug.ps1"
        C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe -File  "$($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname\$($PSGUI_Manager_lvDialogs.SelectedValue.Name)\$($PSGUI_Manager_lvDialogs.SelectedValue.Name).ps1","$($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname\$($PSGUI_Manager_lvDialogs.SelectedValue.Name)\$($PSGUI_Manager_lvDialogs.SelectedValue.Name).psm1","$($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname\$($PSGUI_Manager_lvDialogs.SelectedValue.Name)\$($PSGUI_Manager_lvDialogs.SelectedValue.Name)_Debug.ps1"
    }
)

$PSGUI_Manager_miSave.Add_Click(
    {      
        if ($PSGUI_Manager_lvDialogs.SelectedValue)
        {
            $saveToDialogName = $PSGUI_Manager_lvDialogs.SelectedValue.Name
            if ($PSGUI_Manager_rXAML.IsChecked)
            {
                $PSGUI_Manager_tbCode.Text | Set-Content -Path ([System.IO.Path]::Combine($($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname,"$saveToDialogName\$saveToDialogName.xaml"))
            }
            if($PSGUI_Manager_rCodeBehind.IsChecked)            
            {
                $PSGUI_Manager_tbCode.Text | Set-Content -Path ([System.IO.Path]::Combine($($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname,"$saveToDialogName\$saveToDialogName.ps1"))
            }      
            if($PSGUI_Manager_rFunctions.IsChecked)            
            {
                $PSGUI_Manager_tbCode.Text | Set-Content -Path ([System.IO.Path]::Combine($($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname,"$saveToDialogName\$saveToDialogName.psm1"))
            }
            Initialize-XAMLDialog -XAMLPath ([System.IO.Path]::Combine($($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname,"$saveToDialogName\$saveToDialogName.xaml"))
            $PSGUI_Manager_lvVariables.Items.Clear() 
            $PSGUI_Manager_lvEvents.Items.Clear()                
            
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

                    $PSGUI_Manager_lvVariables.Items.Add($param)
                }
            }   
        }                  
    }
)
#endregion
#===========================================================================

#===========================================================================
#region RadioButton-CodeSwitcher
$PSGUI_Manager_rCodeBehind.Add_Checked(
    {      
        if ($PSGUI_Manager_lvDialogs.SelectedValue)
        {
            $dialogName = $PSGUI_Manager_lvDialogs.SelectedValue.Name
            $xaml = Get-Content -Path ([System.IO.Path]::Combine($($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname,"$dialogName\$dialogName.ps1")) -Raw -Encoding UTF8
            $PSGUI_Manager_tbCode.Text = $xaml              
        }                  
    }
)

$PSGUI_Manager_rXAML.Add_Checked(
    {      
        if ($PSGUI_Manager_lvDialogs.SelectedValue)
        {
            $dialogName = $PSGUI_Manager_lvDialogs.SelectedValue.Name
            $xaml = Get-Content -Path ([System.IO.Path]::Combine($($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname,"$dialogName\$dialogName.xaml")) -Raw -Encoding UTF8
            $PSGUI_Manager_tbCode.Text = $xaml
        }                  
    }
)

$PSGUI_Manager_rFunctions.Add_Checked(
    {      
        if ($PSGUI_Manager_lvDialogs.SelectedValue)
        {
            $dialogName = $PSGUI_Manager_lvDialogs.SelectedValue.Name
            $xaml = Get-Content -Path ([System.IO.Path]::Combine($($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname,"$dialogName\$dialogName.psm1")) -Raw -Encoding UTF8
            $PSGUI_Manager_tbCode.Text = $xaml
        }              
    }
)
#endregion
#===========================================================================

#===========================================================================
#region ListViewEvents
$PSGUI_Manager_lvDialogs.Add_SelectionChanged(
    {      
        if ($PSGUI_Manager_lvDialogs.SelectedValue)
        {
            foreach ($item in $PSGUI_Manager_lvDialogs.Items.Name)
            {
                if ($PSGUI_Manager_lvDialogs.SelectedValue.Name -ne $item)
                {
                    Get-Variable -Name "$item*" | Clear-Variable -Scope Global
                    Get-Variable -Name "$item*" | Remove-Variable -Scope Global
                }                    
            }
            $dialogName = $PSGUI_Manager_lvDialogs.SelectedValue.Name
            $PSGUI_Manager_rXAML.IsChecked = $false
            $PSGUI_Manager_rXAML.IsChecked = $true

            Initialize-XAMLDialog -XAMLPath ([System.IO.Path]::Combine($($PSGUI_Manager_cbDialogFolders.SelectedItem).Fullname,"$dialogName\$dialogName.xaml")) 
            $PSGUI_Manager_lvVariables.Items.Clear() 
            $PSGUI_Manager_lvEvents.Items.Clear()                
            
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

                    $PSGUI_Manager_lvVariables.Items.Add($param)
                }
            }
        }                  
    }
)

$PSGUI_Manager_lvVariables.Add_SelectionChanged(
    { 
        if ($PSGUI_Manager_lvVariables.SelectedValue)
        {      
            #Open the xaml file by raising the checked event      
            $PSGUI_Manager_rCodeBehind.IsChecked = $false
            $PSGUI_Manager_rCodeBehind.IsChecked = $true
            #Re-render
            $PSGUI_Manager.Dispatcher.Invoke([action]{

            },'Render')
      
            $PSGUI_Manager_lvEvents.Items.Clear()   
            $object = $PSGUI_Manager_lvVariables.SelectedValue.Name 

            $Events = ($((Get-Variable -Name $object).Value).GetType()).GetEvents().Name | Sort-Object

            foreach ($Event in $Events)
            {
                $FunctionNameForEvent = "$" + $PSGUI_Manager_lvVariables.SelectedValue.Name + '.Add_' + $Event
                $matches = [regex]::Matches(($PSGUI_Manager_tbCode.Text).ToLower(),'(\{0})' -f $FunctionNameForEvent.ToLower())
                        
                $set = 'normal'
                if ($matches.Count -gt 0)
                {
                    $set = 'bold'
                }

                $param = [PSCustomObject]@{
                    Set  = $set
                    Name = "$Event"
                }      
            
                $PSGUI_Manager_lvEvents.Items.Add($param)               
            } 
            $PSGUI_Manager_lvEvents.ScrollIntoView($PSGUI_Manager_lvEvents.Items[0])       
        }
    }
)

$PSGUI_Manager_lvEvents.Add_MouseDoubleClick(
    { 
        if ($PSGUI_Manager_lvEvents.SelectedValue)
        {            
            #prove if the event handler exists
            $FunctionNameForEvent = "$" + $PSGUI_Manager_lvVariables.SelectedValue.Name + '.Add_' + $PSGUI_Manager_lvEvents.SelectedValue.Name
            
            #Open the xaml file by raising the checked event      
            $PSGUI_Manager_rCodeBehind.IsChecked = $false
            $PSGUI_Manager_rCodeBehind.IsChecked = $true
            #Re-render
            $PSGUI_Manager.Dispatcher.Invoke([action]{

            },'Render')

            $newLine = [Environment]::NewLine
            $tab = "`t"
            $matches = [regex]::Matches(($PSGUI_Manager_tbCode.Text).ToLower(),'(\{0})' -f $FunctionNameForEvent.ToLower())

            if ($matches.Count -eq 0)
            {
                $PSGUI_Manager_tbCode.Text = "$($PSGUI_Manager_tbCode.Text)$newLine$newLine$FunctionNameForEvent($newLine$tab{$newLine$newLine$tab}$newLine)"
                $PSGUI_Manager_tbCode.ScrollToEnd()
            }
            else
            {              
                $PSGUI_Manager_tbCode.ScrollToLine([Math]::Round(($PSGUI_Manager_tbCode.Text.Substring(0,$matches[0].Index)).Split($newLine).Count/2 - 1))
                $PSGUI_Manager.Dispatcher.Invoke([action]{

                },'Render')
            }
        }
    }
)
#endregion
#===========================================================================

#endregion
#===========================================================================