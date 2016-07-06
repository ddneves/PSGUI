<#	
    .NOTES
    ===========================================================================
        Created on:   	04.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        Example_PSGUI_Manager
        Filename:       Example_PSGUI_Manager.ps1
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

$Example_PSGUI_Manager.Add_Loaded(
        {
            Get-ChildItem $Example_PSGUI_Manager_DialogFolder -Directory | % { 
            $param=[PSCustomObject]@{
                    Name = $_.Name
                } 
            $Example_PSGUI_Manager_lvDialogs.Items.Add($param) | Out-Null
        }
    }
)


$Example_PSGUI_Manager.Add_Closed(
    {
       # foreach ($item in $Example_PSGUI_Manager_lvDialogs.Items.Name)
       # {
       #     Get-Variable -Name "$item*" | Clear-Variable -Scope global -Force
       #     Get-Variable -Name "$item*" | Remove-Variable -Scope global -Force
       # }
       # Get-Variable -Name Example_PSGUI_Manager* | Clear-Variable -Scope global -Force
       # Get-Variable -Name Example_PSGUI_Manager* | Remove-Variable -Scope global -Force
    }
)

#endregion
#===========================================================================


#===========================================================================
#region EventHandler

    #===========================================================================
    #region MenuItems
        $Example_PSGUI_Manager_miQuit.Add_Click(
            {
                $Example_PSGUI_Manager.Close()
            }
        )

        $Example_PSGUI_Manager_miAbout.Add_Click(
            {
                
            }
        )
                      
    
    #endregion
    #===========================================================================

    #===========================================================================
    #region ButtonClicks
    $Example_PSGUI_Manager_bCreateNewDialog.Add_Click(
            {
                Open-XAMLDialog -DialogName ('Internal_UserInput')  
                New-XAMLDialog -DialogName $Returnvalue_Internal_UserInput -DialogPath $Example_PSGUI_Manager_DialogFolder
                $Example_PSGUI_Manager_lvDialogs.Items.Clear()
                Get-ChildItem $Example_PSGUI_Manager_DialogFolder -Directory | % { 
                $param=[PSCustomObject]@{
                        Name = $_.Name
                    } 
                $Example_PSGUI_Manager_lvDialogs.Items.Add($param)        
            }
        }
    )

    $Example_PSGUI_Manager_bRenameDialog.Add_Click(
            {
                Open-XAMLDialog -DialogName ('Internal_UserInput')  
                Rename-XAMLDialog -DialogName ($Example_PSGUI_Manager_lvDialogs.SelectedValue.Name) -DialogPath $Example_PSGUI_Manager_DialogFolder -NewDialogName $Returnvalue_Internal_UserInput

                $Example_PSGUI_Manager_lvDialogs.Items.Clear()
                Get-ChildItem $Example_PSGUI_Manager_DialogFolder -Directory | % { 
                $param=[PSCustomObject]@{
                        Name = $_.Name
                    } 
                $Example_PSGUI_Manager_lvDialogs.Items.Add($param)        
            }
        }
    )

    $Example_PSGUI_Manager_bDeleteDialog.Add_Click(
            {
                Open-XAMLDialog -DialogName ('Internal_AskIfSureInput')  

                Rename-XAMLDialog -DialogName ($Example_PSGUI_Manager_lvDialogs.SelectedValue.Name) -DialogPath $Example_PSGUI_Manager_DialogFolder -NewDialogName $Returnvalue_Internal_UserInput

                $Example_PSGUI_Manager_lvDialogs.Items.Clear()
                Get-ChildItem $Example_PSGUI_Manager_DialogFolder -Directory | % { 
                $param=[PSCustomObject]@{
                        Name = $_.Name
                    } 
                $Example_PSGUI_Manager_lvDialogs.Items.Add($param)        
            }
        }
    )

    #ButtonClick
    $Example_PSGUI_Manager_bShowDialog.Add_Click(
        {
            if ($Example_PSGUI_Manager_lvDialogs.SelectedValue)
            {
                Get-Variable -Name "$($Example_PSGUI_Manager_lvDialogs.SelectedValue.Name)*" | Clear-Variable -Scope global
                Get-Variable -Name "$($Example_PSGUI_Manager_lvDialogs.SelectedValue.Name)*" | Remove-Variable -Scope global
                #Invoke-Expression -Command "`$$($Example_PSGUI_Manager_lvDialogs.SelectedValue.Name).Show() | Out-Null" -ErrorAction Continue
                Open-XAMLDialog -DialogName ($Example_PSGUI_Manager_lvDialogs.SelectedValue.Name) -DialogPath "$Example_PSGUI_Manager_DialogFolder\$($Example_PSGUI_Manager_lvDialogs.SelectedValue.Name)" -OpenWithOnlyShowFlag
            } 
        }
    )

    $Example_PSGUI_Manager_bSaveCode.Add_Click(
        {      
            if ($Example_PSGUI_Manager_lvDialogs.SelectedValue)
            {
                $saveToDialogName = $Example_PSGUI_Manager_lvDialogs.SelectedValue.Name
                if ($Example_PSGUI_Manager_rXAML.IsChecked)
                {
                    $Example_PSGUI_Manager_tbCode.Text | Set-Content "$Example_PSGUI_Manager_DialogFolder\$saveToDialogName\$saveToDialogName.xaml" 
                }
                if($Example_PSGUI_Manager_rCodeBehind.IsChecked)            
                {
                    $Example_PSGUI_Manager_tbCode.Text | Set-Content "$Example_PSGUI_Manager_DialogFolder\$saveToDialogName\$saveToDialogName.ps1" 
                }      
                if($Example_PSGUI_Manager_rFunctions.IsChecked)            
                {
                    $Example_PSGUI_Manager_tbCode.Text | Set-Content "$Example_PSGUI_Manager_DialogFolder\$saveToDialogName\$saveToDialogName.psm1" 
                }         
            }                  
        }
    )
    #endregion
    #===========================================================================

    #===========================================================================
    #region RadioButton-CodeSwitcher
        $Example_PSGUI_Manager_rCodeBehind.Add_Checked(
            {      
                if ($Example_PSGUI_Manager_lvDialogs.SelectedValue)
                {
                    $dialogName=$Example_PSGUI_Manager_lvDialogs.SelectedValue.Name
                    $xaml= Get-Content "$Example_PSGUI_Manager_DialogFolder\$dialogName\$dialogName.ps1" -Raw -Encoding UTF8
                    $Example_PSGUI_Manager_tbCode.Text=$xaml              
                }                  
            }
        )

        $Example_PSGUI_Manager_rXAML.Add_Checked(
            {      
                if ($Example_PSGUI_Manager_lvDialogs.SelectedValue)
                {
                    $dialogName=$Example_PSGUI_Manager_lvDialogs.SelectedValue.Name
                    $xaml= Get-Content "$Example_PSGUI_Manager_DialogFolder\$dialogName\$dialogName.xaml" -Raw -Encoding UTF8
                    $Example_PSGUI_Manager_tbCode.Text=$xaml
                }                  
            }
        )

        $Example_PSGUI_Manager_rFunctions.Add_Checked(
            {      
                if ($Example_PSGUI_Manager_lvDialogs.SelectedValue)
                {
                    $dialogName=$Example_PSGUI_Manager_lvDialogs.SelectedValue.Name
                    $xaml= Get-Content "$Example_PSGUI_Manager_DialogFolder\$dialogName\$dialogName.psm1" -Raw -Encoding UTF8
                    $Example_PSGUI_Manager_tbCode.Text=$xaml
                }              
            }
        )
    #endregion
    #===========================================================================

    #===========================================================================
    #region ListViewEvents
        $Example_PSGUI_Manager_lvDialogs.Add_SelectionChanged(
            {      
              #  foreach ($item in $Example_PSGUI_Manager_lvDialogs.Items.Name)
              #  {
              #      if ($Example_PSGUI_Manager_lvDialogs.SelectedValue.Name -ne $item)
              #      {
              #          Get-Variable -Name "$item*" | Clear-Variable
              #          Get-Variable -Name "$item*" | Remove-Variable
              #      }                    
              #  }

                if ($Example_PSGUI_Manager_lvDialogs.SelectedValue)
                {
                    $dialogName=$Example_PSGUI_Manager_lvDialogs.SelectedValue.Name
                    $Example_PSGUI_Manager_rXAML.IsChecked=$false
                    $Example_PSGUI_Manager_rXAML.IsChecked=$true

                    Initialize-XAMLDialog -XAMLPath "$Example_PSGUI_Manager_DialogFolder\$dialogName\$dialogName.xaml" 
                    #Open-XAMLDialog -DialogName "$dialogName" -DialogPath "$Example_PSGUI_Manager_DialogFolder\$dialogName" -OnlyCreateVariables
                    $Example_PSGUI_Manager_lvVariables.Items.Clear()            
            
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

                            $Example_PSGUI_Manager_lvVariables.Items.Add($param)
                        }
                    }
                }                  
            }
        )

        $Example_PSGUI_Manager_lvVariables.Add_SelectionChanged(
            { 
                if ($Example_PSGUI_Manager_lvVariables.SelectedValue)
                {      
                    #Open the xaml file by raising the checked event      
                    $Example_PSGUI_Manager_rCodeBehind.IsChecked=$false
                    $Example_PSGUI_Manager_rCodeBehind.IsChecked=$true
                    #Re-render
                    $Example_PSGUI_Manager.Dispatcher.Invoke([action]{},'Render')
      
                    $Example_PSGUI_Manager_lvEvents.Items.Clear()   
                    $object = $Example_PSGUI_Manager_lvVariables.SelectedValue.Name 
                    Invoke-Expression -Command "`$Events = (`$$object.GetType()).GetEvents().Name | Sort-Object"

                    foreach ($Event in $Events)
                    {
                        $FunctionNameForEvent = "$" + $Example_PSGUI_Manager_lvVariables.SelectedValue.Name + '.Add_' + $Event
                        $matches = [regex]::Matches(($Example_PSGUI_Manager_tbCode.Text).ToLower(),'(\{0})' -f $FunctionNameForEvent.ToLower())
                        $param=[PSCustomObject]@{
                            Set = ($Matches.Count -gt 0)
                            Name = "$Event"                    
                        }      
            
                        $Example_PSGUI_Manager_lvEvents.Items.Add($param)               
                    } 
                    $Example_PSGUI_Manager_lvEvents.ScrollIntoView($Example_PSGUI_Manager_lvEvents.Items[0])       
                }
            }
        )

        $Example_PSGUI_Manager_lvEvents.Add_MouseDoubleClick(
            { 
                if ($Example_PSGUI_Manager_lvEvents.SelectedValue)
                {            
                    #prove if the event handler exists
                    $FunctionNameForEvent = "$" + $Example_PSGUI_Manager_lvVariables.SelectedValue.Name + '.Add_' + $Example_PSGUI_Manager_lvEvents.SelectedValue.Name
            
                    #Open the xaml file by raising the checked event      
                    $Example_PSGUI_Manager_rCodeBehind.IsChecked=$false
                    $Example_PSGUI_Manager_rCodeBehind.IsChecked=$true
                    #Re-render
                    $Example_PSGUI_Manager.Dispatcher.Invoke([action]{},'Render')


                    $newLine = [Environment]::NewLine
                    $tab = "`t"
                    $matches = [regex]::Matches(($Example_PSGUI_Manager_tbCode.Text).ToLower(),'(\{0})' -f $FunctionNameForEvent.ToLower())

                    if ( $matches.Count -eq 0)
                    {
                        $Example_PSGUI_Manager_tbCode.Text="$($Example_PSGUI_Manager_tbCode.Text)$newLine$newLine$FunctionNameForEvent($newLine$tab{$newLine$newline$tab}$newLine)"
                        $Example_PSGUI_Manager_tbCode.ScrollToEnd()
                    }
                    else
                    {              
                        $Example_PSGUI_Manager_tbCode.ScrollToLine([Math]::Round(($Example_PSGUI_Manager_tbCode.Text.Substring(0,$matches[0].Index)).Split($newLine).Count/2 - 1));
                        $Example_PSGUI_Manager.Dispatcher.Invoke([action]{},'Render')
                    }
                }
            }
        )
    #endregion
    #===========================================================================

#endregion
#===========================================================================
