#region PreFilling

#endregion


#region EventHandler
$Example_UserInput.Add_Closed(
    {
        #Get-Variable -Name Example_UserInput* | Clear-Variable
        #Get-Variable -Name Example_UserInput* | Remove-Variable
    }
)


#endregion


$Example_UserInput_bOK.Add_Click(
    {
        Set-Variable -Name ReturnvalueUserInput -Value $Example_UserInput_tbInput.Text -Scope global
        $Example_UserInput.Close()
   }
)

$Example_UserInput.Add_KeyDown(
	{
     		if ($_.Key -eq "Return")
        		{
            			Set-Variable -Name ReturnvalueUserInput -Value $Example_UserInput_tbInput.Text -Scope global
        			$Example_UserInput.Close()
        		}
	}
)




