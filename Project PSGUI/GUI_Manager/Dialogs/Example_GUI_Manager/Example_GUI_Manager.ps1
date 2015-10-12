<#	
    .NOTES
    ===========================================================================
        Created on:   	04.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        Example_GUI_Manager
        Filename:       Example_GUI_Manager.ps1
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

$Example_GUI_Manager.Add_Loaded(
        {
            Get-ChildItem $Example_GUI_Manager_DialogFolder -Directory | % { 
            $param=[PSCustomObject]@{
                    Name = $_.Name
                } 
            $Example_GUI_Manager_lvDialogs.Items.Add($param) | Out-Null
        }
    }
)


$Example_GUI_Manager.Add_Closed(
    {
       # foreach ($item in $Example_GUI_Manager_lvDialogs.Items.Name)
       # {
       #     Get-Variable -Name "$item*" | Clear-Variable -Scope global -Force
       #     Get-Variable -Name "$item*" | Remove-Variable -Scope global -Force
       # }
       # Get-Variable -Name Example_GUI_Manager* | Clear-Variable -Scope global -Force
       # Get-Variable -Name Example_GUI_Manager* | Remove-Variable -Scope global -Force
    }
)

#endregion
#===========================================================================


#===========================================================================
#region EventHandler

    #===========================================================================
    #region MenuItems
        $Example_GUI_Manager_miQuit.Add_Click(
            {
                $Example_GUI_Manager.Close()
            }
        )

        $Example_GUI_Manager_miAbout.Add_Click(
            {
                
            }
        )
                      
    
    #endregion
    #===========================================================================

    #===========================================================================
    #region ButtonClicks
    $Example_GUI_Manager_bCreateNewDialog.Add_Click(
            {
                Open-XAMLDialog -DialogName ('Internal_UserInput')  
                New-XAMLDialog -DialogName $Returnvalue_Internal_UserInput -DialogPath $Example_GUI_Manager_DialogFolder
                $Example_GUI_Manager_lvDialogs.Items.Clear()
                Get-ChildItem $Example_GUI_Manager_DialogFolder -Directory | % { 
                $param=[PSCustomObject]@{
                        Name = $_.Name
                    } 
                $Example_GUI_Manager_lvDialogs.Items.Add($param)        
            }
        }
    )

    $Example_GUI_Manager_bRenameDialog.Add_Click(
            {
                Open-XAMLDialog -DialogName ('Internal_UserInput')  
                Rename-XAMLDialog -DialogName ($Example_GUI_Manager_lvDialogs.SelectedValue.Name) -DialogPath $Example_GUI_Manager_DialogFolder -NewDialogName $Returnvalue_Internal_UserInput

                $Example_GUI_Manager_lvDialogs.Items.Clear()
                Get-ChildItem $Example_GUI_Manager_DialogFolder -Directory | % { 
                $param=[PSCustomObject]@{
                        Name = $_.Name
                    } 
                $Example_GUI_Manager_lvDialogs.Items.Add($param)        
            }
        }
    )

    $Example_GUI_Manager_bDeleteDialog.Add_Click(
            {
                Open-XAMLDialog -DialogName ('Internal_AskIfSureInput')  

                Rename-XAMLDialog -DialogName ($Example_GUI_Manager_lvDialogs.SelectedValue.Name) -DialogPath $Example_GUI_Manager_DialogFolder -NewDialogName $Returnvalue_Internal_UserInput

                $Example_GUI_Manager_lvDialogs.Items.Clear()
                Get-ChildItem $Example_GUI_Manager_DialogFolder -Directory | % { 
                $param=[PSCustomObject]@{
                        Name = $_.Name
                    } 
                $Example_GUI_Manager_lvDialogs.Items.Add($param)        
            }
        }
    )

    #ButtonClick
    $Example_GUI_Manager_bShowDialog.Add_Click(
        {
            if ($Example_GUI_Manager_lvDialogs.SelectedValue)
            {
                Get-Variable -Name "$($Example_GUI_Manager_lvDialogs.SelectedValue.Name)*" | Clear-Variable -Scope global
                Get-Variable -Name "$($Example_GUI_Manager_lvDialogs.SelectedValue.Name)*" | Remove-Variable -Scope global
                #Invoke-Expression -Command "`$$($Example_GUI_Manager_lvDialogs.SelectedValue.Name).Show() | Out-Null" -ErrorAction Continue
                Open-XAMLDialog -DialogName ($Example_GUI_Manager_lvDialogs.SelectedValue.Name) -DialogPath "$Example_GUI_Manager_DialogFolder\$($Example_GUI_Manager_lvDialogs.SelectedValue.Name)" -OpenWithOnlyShowFlag
            } 
        }
    )

    $Example_GUI_Manager_bSaveCode.Add_Click(
        {      
            if ($Example_GUI_Manager_lvDialogs.SelectedValue)
            {
                $saveToDialogName = $Example_GUI_Manager_lvDialogs.SelectedValue.Name
                if ($Example_GUI_Manager_rXAML.IsChecked)
                {
                    $Example_GUI_Manager_tbCode.Text | Set-Content "$Example_GUI_Manager_DialogFolder\$saveToDialogName\$saveToDialogName.xaml" 
                }
                if($Example_GUI_Manager_rCodeBehind.IsChecked)            
                {
                    $Example_GUI_Manager_tbCode.Text | Set-Content "$Example_GUI_Manager_DialogFolder\$saveToDialogName\$saveToDialogName.ps1" 
                }      
                if($Example_GUI_Manager_rFunctions.IsChecked)            
                {
                    $Example_GUI_Manager_tbCode.Text | Set-Content "$Example_GUI_Manager_DialogFolder\$saveToDialogName\$saveToDialogName.psm1" 
                }         
            }                  
        }
    )
    #endregion
    #===========================================================================

    #===========================================================================
    #region RadioButton-CodeSwitcher
        $Example_GUI_Manager_rCodeBehind.Add_Checked(
            {      
                if ($Example_GUI_Manager_lvDialogs.SelectedValue)
                {
                    $dialogName=$Example_GUI_Manager_lvDialogs.SelectedValue.Name
                    $xaml= Get-Content "$Example_GUI_Manager_DialogFolder\$dialogName\$dialogName.ps1" -Raw -Encoding UTF8
                    $Example_GUI_Manager_tbCode.Text=$xaml              
                }                  
            }
        )

        $Example_GUI_Manager_rXAML.Add_Checked(
            {      
                if ($Example_GUI_Manager_lvDialogs.SelectedValue)
                {
                    $dialogName=$Example_GUI_Manager_lvDialogs.SelectedValue.Name
                    $xaml= Get-Content "$Example_GUI_Manager_DialogFolder\$dialogName\$dialogName.xaml" -Raw -Encoding UTF8
                    $Example_GUI_Manager_tbCode.Text=$xaml
                }                  
            }
        )

        $Example_GUI_Manager_rFunctions.Add_Checked(
            {      
                if ($Example_GUI_Manager_lvDialogs.SelectedValue)
                {
                    $dialogName=$Example_GUI_Manager_lvDialogs.SelectedValue.Name
                    $xaml= Get-Content "$Example_GUI_Manager_DialogFolder\$dialogName\$dialogName.psm1" -Raw -Encoding UTF8
                    $Example_GUI_Manager_tbCode.Text=$xaml
                }              
            }
        )
    #endregion
    #===========================================================================

    #===========================================================================
    #region ListViewEvents
        $Example_GUI_Manager_lvDialogs.Add_SelectionChanged(
            {      
              #  foreach ($item in $Example_GUI_Manager_lvDialogs.Items.Name)
              #  {
              #      if ($Example_GUI_Manager_lvDialogs.SelectedValue.Name -ne $item)
              #      {
              #          Get-Variable -Name "$item*" | Clear-Variable
              #          Get-Variable -Name "$item*" | Remove-Variable
              #      }                    
              #  }

                if ($Example_GUI_Manager_lvDialogs.SelectedValue)
                {
                    $dialogName=$Example_GUI_Manager_lvDialogs.SelectedValue.Name
                    $Example_GUI_Manager_rXAML.IsChecked=$false
                    $Example_GUI_Manager_rXAML.IsChecked=$true

                    Initialize-XAMLDialog -XAMLPath "$Example_GUI_Manager_DialogFolder\$dialogName\$dialogName.xaml" 
                    #Open-XAMLDialog -DialogName "$dialogName" -DialogPath "$Example_GUI_Manager_DialogFolder\$dialogName" -OnlyCreateVariables
                    $Example_GUI_Manager_lvVariables.Items.Clear()            
            
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

                            $Example_GUI_Manager_lvVariables.Items.Add($param)
                        }
                    }
                }                  
            }
        )

        $Example_GUI_Manager_lvVariables.Add_SelectionChanged(
            { 
                if ($Example_GUI_Manager_lvVariables.SelectedValue)
                {      
                    #Open the xaml file by raising the checked event      
                    $Example_GUI_Manager_rCodeBehind.IsChecked=$false
                    $Example_GUI_Manager_rCodeBehind.IsChecked=$true
                    #Re-render
                    $Example_GUI_Manager.Dispatcher.Invoke([action]{},'Render')
      
                    $Example_GUI_Manager_lvEvents.Items.Clear()   
                    $object = $Example_GUI_Manager_lvVariables.SelectedValue.Name 
                    Invoke-Expression -Command "`$Events = (`$$object.GetType()).GetEvents().Name | Sort-Object"

                    foreach ($Event in $Events)
                    {
                        $FunctionNameForEvent = "$" + $Example_GUI_Manager_lvVariables.SelectedValue.Name + '.Add_' + $Event
                        $matches = [regex]::Matches(($Example_GUI_Manager_tbCode.Text).ToLower(),'(\{0})' -f $FunctionNameForEvent.ToLower())
                        $param=[PSCustomObject]@{
                            Set = ($Matches.Count -gt 0)
                            Name = "$Event"                    
                        }      
            
                        $Example_GUI_Manager_lvEvents.Items.Add($param)               
                    } 
                    $Example_GUI_Manager_lvEvents.ScrollIntoView($Example_GUI_Manager_lvEvents.Items[0])       
                }
            }
        )

        $Example_GUI_Manager_lvEvents.Add_MouseDoubleClick(
            { 
                if ($Example_GUI_Manager_lvEvents.SelectedValue)
                {            
                    #prove if the event handler exists
                    $FunctionNameForEvent = "$" + $Example_GUI_Manager_lvVariables.SelectedValue.Name + '.Add_' + $Example_GUI_Manager_lvEvents.SelectedValue.Name
            
                    #Open the xaml file by raising the checked event      
                    $Example_GUI_Manager_rCodeBehind.IsChecked=$false
                    $Example_GUI_Manager_rCodeBehind.IsChecked=$true
                    #Re-render
                    $Example_GUI_Manager.Dispatcher.Invoke([action]{},'Render')


                    $newLine = [Environment]::NewLine
                    $tab = "`t"
                    $matches = [regex]::Matches(($Example_GUI_Manager_tbCode.Text).ToLower(),'(\{0})' -f $FunctionNameForEvent.ToLower())

                    if ( $matches.Count -eq 0)
                    {
                        $Example_GUI_Manager_tbCode.Text="$($Example_GUI_Manager_tbCode.Text)$newLine$newLine$FunctionNameForEvent($newLine$tab{$newLine$newline$tab}$newLine)"
                        $Example_GUI_Manager_tbCode.ScrollToEnd()
                    }
                    else
                    {              
                        $Example_GUI_Manager_tbCode.ScrollToLine([Math]::Round(($Example_GUI_Manager_tbCode.Text.Substring(0,$matches[0].Index)).Split($newLine).Count/2 - 1));
                        $Example_GUI_Manager.Dispatcher.Invoke([action]{},'Render')
                    }
                }
            }
        )
    #endregion
    #===========================================================================

#endregion
#===========================================================================
