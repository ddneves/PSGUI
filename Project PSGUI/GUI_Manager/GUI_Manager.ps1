<#	
    .NOTES
    ===========================================================================
        Created on:   	08.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        GUI_Manager
        Filename:       GUI_Manager.ps1
    ===========================================================================
    .DESCRIPTION
        Code-Behind for GUI-Manager.
#> 

#===========================================================================
#region functions

#endregion
#===========================================================================

#===========================================================================
#region PreFilling

$GUI_Manager.Add_Loaded(
        {
            Get-ChildItem $GUI_Manager_DialogFolder -Directory | % { 
            $param=[PSCustomObject]@{
                    Name = $_.Name
                } 
            $GUI_Manager_lvDialogs.Items.Add($param) | Out-Null
            $GUI_Manager.Activate()            
        }
    }
)

$GUI_Manager.Add_Closed(
    {
        foreach ($item in $GUI_Manager_lvDialogs.Items.Name)
        {
            Get-Variable -Name "$item*" | Clear-Variable -Scope global -Force
            Get-Variable -Name "$item*" | Remove-Variable -Scope global -Force
        }
        Get-Variable -Name GUI_Manager* | Clear-Variable -Scope global -Force
        Get-Variable -Name GUI_Manager* | Remove-Variable -Scope global -Force
    }
)

$GUI_Manager.Add_PreviewKeyDown(
    {
        if(([System.Windows.Input.Keyboard]::IsKeyDown('Ctrl') -eq $true) -and $_.Key -eq "S") 
        { 
            $GUI_Manager_miSave.RaiseEvent((New-Object -TypeName System.Windows.RoutedEventArgs -ArgumentList $([System.Windows.Controls.MenuItem]::ClickEvent)))
        }
        if(([System.Windows.Input.Keyboard]::IsKeyDown('Ctrl') -eq $true) -and $_.Key -eq "R") 
        { 
            $GUI_Manager_miRenderDialog.RaiseEvent((New-Object -TypeName System.Windows.RoutedEventArgs -ArgumentList $([System.Windows.Controls.MenuItem]::ClickEvent)))
        }
    }
)

#endregion
#===========================================================================


#===========================================================================
#region EventHandler

    #===========================================================================
    #region MenuItems
        $GUI_Manager_miQuit.Add_Click(
            {
                $GUI_Manager.Close()
            }
        )

        $GUI_Manager_miAbout.Add_Click(
            {
                Open-XAMLDialog -DialogName ('Internal_About')  
            }
        )                      
    
    #endregion
    #===========================================================================

    #===========================================================================
    #region ButtonClicks
    $GUI_Manager_miNewDialog.Add_Click(
            {
                Open-XAMLDialog -DialogName ('Internal_UserInput') 
                if ($Returnvalue_Internal_UserInput)
                {     
                    New-XAMLDialog -DialogName $Returnvalue_Internal_UserInput -DialogPath $GUI_Manager_DialogFolder
                    $GUI_Manager_lvDialogs.Items.Clear()
                    Get-ChildItem $GUI_Manager_DialogFolder -Directory | % { 
                    $param=[PSCustomObject]@{
                            Name = $_.Name
                        } 
                    $GUI_Manager_lvDialogs.Items.Add($param)   
                }    
            }
        }
    )

    $GUI_Manager_miRenameDialog.Add_Click(
            {
                Open-XAMLDialog -DialogName ('Internal_UserInput')  
                if ($Returnvalue_Internal_UserInput)
                {     
                    Rename-XAMLDialog -DialogName ($GUI_Manager_lvDialogs.SelectedValue.Name) -DialogPath $GUI_Manager_DialogFolder -NewDialogName $Returnvalue_Internal_UserInput

                    $GUI_Manager_lvDialogs.Items.Clear()
                    Get-ChildItem $GUI_Manager_DialogFolder -Directory | % { 
                    $param=[PSCustomObject]@{
                            Name = $_.Name
                        } 
                    $GUI_Manager_lvDialogs.Items.Add($param)
                }
            }
        }
    )

    $GUI_Manager_miDeleteDialog.Add_Click(
            {
                Open-XAMLDialog -DialogName ('Internal_AskIfSureInput')  

                Rename-XAMLDialog -DialogName ($GUI_Manager_lvDialogs.SelectedValue.Name) -DialogPath $GUI_Manager_DialogFolder -NewDialogName $Returnvalue_Internal_UserInput

                $GUI_Manager_lvDialogs.Items.Clear()
                Get-ChildItem $GUI_Manager_DialogFolder -Directory | % { 
                $param=[PSCustomObject]@{
                        Name = $_.Name
                    } 
                $GUI_Manager_lvDialogs.Items.Add($param)        
            }
        }
    )

    #ButtonClick
    $GUI_Manager_miRenderDialog.Add_Click(
        {
            if ($GUI_Manager_lvDialogs.SelectedValue)
            {
                Get-Variable -Name "$($GUI_Manager_lvDialogs.SelectedValue.Name)*" | Clear-Variable -Scope global
                Get-Variable -Name "$($GUI_Manager_lvDialogs.SelectedValue.Name)*" | Remove-Variable -Scope global
                #Invoke-Expression -Command "`$$($GUI_Manager_lvDialogs.SelectedValue.Name).Show() | Out-Null" -ErrorAction Continue
                Open-XAMLDialog -DialogName ($GUI_Manager_lvDialogs.SelectedValue.Name) -DialogPath "$GUI_Manager_DialogFolder\$($GUI_Manager_lvDialogs.SelectedValue.Name)" -OpenWithOnlyShowFlag
            } 
        }
    )

    $GUI_Manager_miSave.Add_Click(
        {      
            if ($GUI_Manager_lvDialogs.SelectedValue)
            {
                $saveToDialogName = $GUI_Manager_lvDialogs.SelectedValue.Name
                if ($GUI_Manager_rXAML.IsChecked)
                {
                    $GUI_Manager_tbCode.Text | Set-Content "$GUI_Manager_DialogFolder\$saveToDialogName\$saveToDialogName.xaml" 
                }
                if($GUI_Manager_rCodeBehind.IsChecked)            
                {
                    $GUI_Manager_tbCode.Text | Set-Content "$GUI_Manager_DialogFolder\$saveToDialogName\$saveToDialogName.ps1" 
                }      
                if($GUI_Manager_rFunctions.IsChecked)            
                {
                    $GUI_Manager_tbCode.Text | Set-Content "$GUI_Manager_DialogFolder\$saveToDialogName\$saveToDialogName.psm1" 
                }         
            }                  
        }
    )
    
    $GUI_Manager_miCreatePackage.Add_Click(
        {      
            if ($GUI_Manager_lvDialogs.SelectedValue)
            {
                $DialogName = $GUI_Manager_lvDialogs.SelectedValue.Name
                if ($DialogName -notlike 'Example_*' -and $DialogName -notlike 'Internal_*')
                {
                    New-PackageByDialog -DialogName $DialogName -Dialogpath "$GUI_Manager_DialogFolder\$DialogName" -OutputName $DialogName    
                }
                else
                {
                    #TODO INFOBOX - Examples and internal functions cant be packaged.
                }
                
            }                  
        }
    )
        
    #endregion
    #===========================================================================

    #===========================================================================
    #region RadioButton-CodeSwitcher
        $GUI_Manager_rCodeBehind.Add_Checked(
            {      
                if ($GUI_Manager_lvDialogs.SelectedValue)
                {
                    $dialogName=$GUI_Manager_lvDialogs.SelectedValue.Name
                    $xaml= Get-Content "$GUI_Manager_DialogFolder\$dialogName\$dialogName.ps1" -Raw -Encoding UTF8
                    $GUI_Manager_tbCode.Text=$xaml              
                }                  
            }
        )

        $GUI_Manager_rXAML.Add_Checked(
            {      
                if ($GUI_Manager_lvDialogs.SelectedValue)
                {
                    $dialogName=$GUI_Manager_lvDialogs.SelectedValue.Name
                    $xaml= Get-Content "$GUI_Manager_DialogFolder\$dialogName\$dialogName.xaml" -Raw -Encoding UTF8
                    $GUI_Manager_tbCode.Text=$xaml
                }                  
            }
        )

        $GUI_Manager_rFunctions.Add_Checked(
            {      
                if ($GUI_Manager_lvDialogs.SelectedValue)
                {
                    $dialogName=$GUI_Manager_lvDialogs.SelectedValue.Name
                    $xaml= Get-Content "$GUI_Manager_DialogFolder\$dialogName\$dialogName.psm1" -Raw -Encoding UTF8
                    $GUI_Manager_tbCode.Text=$xaml
                }              
            }
        )
    #endregion
    #===========================================================================

    #===========================================================================
    #region ListViewEvents
        $GUI_Manager_lvDialogs.Add_SelectionChanged(
            {      
                if ($GUI_Manager_lvDialogs.SelectedValue)
                {
                    foreach ($item in $GUI_Manager_lvDialogs.Items.Name)
                    {
                        if ($GUI_Manager_lvDialogs.SelectedValue.Name -ne $item)
                        {
                            Get-Variable -Name "$item*" | Clear-Variable -Scope Global
                            Get-Variable -Name "$item*" | Remove-Variable -Scope Global
                        }                    
                    }
                    $dialogName=$GUI_Manager_lvDialogs.SelectedValue.Name
                    $GUI_Manager_rXAML.IsChecked=$false
                    $GUI_Manager_rXAML.IsChecked=$true

                    Initialize-XAMLDialog -XAMLPath "$GUI_Manager_DialogFolder\$dialogName\$dialogName.xaml" 
                    #Open-XAMLDialog -DialogName "$dialogName" -DialogPath "$GUI_Manager_DialogFolder\$dialogName" -OnlyCreateVariables
                    $GUI_Manager_lvVariables.Items.Clear() 
                    $GUI_Manager_lvEvents.Items.Clear()                
            
                    $variables = Get-Variable "$dialogName*"
                      
                    foreach ($var in $variables)
                    {
                        if ($var -and $var.Name -and $var.Value)
                        {
                            $varValue=(($var.Value.ToString()).Replace('System.Windows.','')).Replace('Controls.','')
                     
                            $param=[PSCustomObject]@{
                                Name =    "$($var.Name)"
                                Objekt =  "$varvalue"
                            }      

                            $GUI_Manager_lvVariables.Items.Add($param)
                        }
                    }
                }                  
            }
        )

        $GUI_Manager_lvVariables.Add_SelectionChanged(
            { 
                if ($GUI_Manager_lvVariables.SelectedValue)
                {      
                    #Open the xaml file by raising the checked event      
                    $GUI_Manager_rCodeBehind.IsChecked=$false
                    $GUI_Manager_rCodeBehind.IsChecked=$true
                    #Re-render
                    $GUI_Manager.Dispatcher.Invoke([action]{},'Render')
      
                    $GUI_Manager_lvEvents.Items.Clear()   
                    $object = $GUI_Manager_lvVariables.SelectedValue.Name 
                    Invoke-Expression -Command "`$Events = (`$$object.GetType()).GetEvents().Name | Sort-Object"

                    foreach ($Event in $Events)
                    {
                        $FunctionNameForEvent = "$" + $GUI_Manager_lvVariables.SelectedValue.Name + '.Add_' + $Event
                        $matches = [regex]::Matches(($GUI_Manager_tbCode.Text).ToLower(),'(\{0})' -f $FunctionNameForEvent.ToLower())
                        
                        $set = "normal"
                        if ($Matches.Count -gt 0){
                            $set="bold"
                        }

                        $param=[PSCustomObject]@{
                            Set=$set
                            Name = "$Event"                    
                        }      
            
                        $GUI_Manager_lvEvents.Items.Add($param)               
                    } 
                    $GUI_Manager_lvEvents.ScrollIntoView($GUI_Manager_lvEvents.Items[0])       
                }
            }
        )

        $GUI_Manager_lvEvents.Add_MouseDoubleClick(
            { 
                if ($GUI_Manager_lvEvents.SelectedValue)
                {            
                    #prove if the event handler exists
                    $FunctionNameForEvent = "$" + $GUI_Manager_lvVariables.SelectedValue.Name + '.Add_' + $GUI_Manager_lvEvents.SelectedValue.Name
            
                    #Open the xaml file by raising the checked event      
                    $GUI_Manager_rCodeBehind.IsChecked=$false
                    $GUI_Manager_rCodeBehind.IsChecked=$true
                    #Re-render
                    $GUI_Manager.Dispatcher.Invoke([action]{},'Render')

                    $newLine = [Environment]::NewLine
                    $tab = "`t"
                    $matches = [regex]::Matches(($GUI_Manager_tbCode.Text).ToLower(),'(\{0})' -f $FunctionNameForEvent.ToLower())

                    if ($matches.Count -eq 0)
                    {
                        $GUI_Manager_tbCode.Text="$($GUI_Manager_tbCode.Text)$newLine$newLine$FunctionNameForEvent($newLine$tab{$newLine$newline$tab}$newLine)"
                        $GUI_Manager_tbCode.ScrollToEnd()
                    }
                    else
                    {              
                        $GUI_Manager_tbCode.ScrollToLine([Math]::Round(($GUI_Manager_tbCode.Text.Substring(0,$matches[0].Index)).Split($newLine).Count/2 - 1));
                        $GUI_Manager.Dispatcher.Invoke([action]{},'Render')
                    }
                }
            }
        )
    #endregion
    #===========================================================================

#endregion
#===========================================================================