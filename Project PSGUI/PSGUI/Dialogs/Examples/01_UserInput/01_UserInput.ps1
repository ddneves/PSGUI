#region PreFilling

#endregion


#region EventHandler
$01_UserInput.Add_Closed(
    {
        #Get-Variable -Name 01_UserInput* | Clear-Variable
        #Get-Variable -Name 01_UserInput* | Remove-Variable
    }
)


#endregion


$01_UserInput_bOK.Add_Click(
    {
        Set-Variable -Name ReturnvalueUserInput -Value $01_UserInput_tbInput.Text -Scope global
        $01_UserInput.Close()
   }
)

$01_UserInput.Add_KeyDown(
	{
     		if ($_.Key -eq "Return")
        		{
            			Set-Variable -Name ReturnvalueUserInput -Value $01_UserInput_tbInput.Text -Scope global
        			$01_UserInput.Close()
        		}
	}
)




