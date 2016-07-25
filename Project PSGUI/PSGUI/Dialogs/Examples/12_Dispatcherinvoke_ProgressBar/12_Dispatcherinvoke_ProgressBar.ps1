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


$12_Dispatcherinvoke_ProgressBar_bProgress.Add_Click(
	{
        #Init CancelLoop
  
        #Reset the Progress Bar
        $12_Dispatcherinvoke_ProgressBar_pbProgress.Value = 0
        $12_Dispatcherinvoke_ProgressBar_pbProgress.Maximum = 4
    
        for($i = 0; $i -lt $12_Dispatcherinvoke_ProgressBar_pbProgress.Maximum; $i++)
        {
            Start-Sleep -Seconds 1
            $12_Dispatcherinvoke_ProgressBar_pbProgress.Value++
            $12_Dispatcherinvoke_ProgressBar.Dispatcher.Invoke([action]{},'Render')          
        } 
    	}
)
