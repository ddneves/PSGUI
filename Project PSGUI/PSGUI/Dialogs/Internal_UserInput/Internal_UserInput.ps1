<#	
    .NOTES
    ===========================================================================
        Created on:   	04.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       Internal_UserInput.ps1
    ===========================================================================
    .DESCRIPTION
	Internal Dialog: UserInput
#> 
#region PreFilling
$Internal_UserInput.Add_Loaded(
        {
            Set-Variable -Name Returnvalue_Internal_UserInput -Value "" -Scope global
            $Internal_UserInput.Activate()
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
        Set-Variable -Name Returnvalue_Internal_UserInput -Value "" -Scope global
        $Internal_UserInput.Close()
   }
)

#endregion



