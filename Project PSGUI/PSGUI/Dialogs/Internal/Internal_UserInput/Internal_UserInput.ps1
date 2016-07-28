<#	
    .NOTES
    ===========================================================================
        Created on:   	25.07.2016
        Created by:   	David das Neves
        Version:        0.5
        Project:        PSGUI
        Filename:       Internal_UserInput.ps1
    ===========================================================================
    .DESCRIPTION
	Internal Dialog: UserInput
#> 
#region PreFilling
$Internal_UserInput.Add_Loaded(
        {
            Set-Variable -Name Returnvalue_Internal_UserInput -Value '' -Scope global
            $Internal_UserInput.Title = $Title_Internal_UserInput
            $Internal_UserInput.Activate()
            $Internal_UserInput_tbInput.Text = $Returnvalue_Internal_UserInput
            $Internal_UserInput_tbInput.Focus()
        }
)
#endregion


#region EventHandler


$Internal_UserInput_bOK.Add_Click(
    {
        Set-Variable -Name Returnvalue_Internal_UserInput -Value $Internal_UserInput_tbInput.Text -Scope global
        $Internal_UserInput.Close()
   }
)

$Internal_UserInput_bCancel.Add_Click(
    {
        Set-Variable -Name Returnvalue_Internal_UserInput -Value '' -Scope global
        $Internal_UserInput.Close()
   }
)

$Internal_UserInput_tbInput.Add_KeyDown(
    {
        if ($_.Key -eq 'Return')
        {
            Set-Variable -Name Returnvalue_Internal_UserInput -Value $Internal_UserInput_tbInput.Text -Scope global
            $Internal_UserInput.Close()
        }
        
   }
)


#endregion



