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


$MouseTracker.Add_Loaded({
        #Create Timer object
        Write-Verbose "Creating timer object"
        $Script:timer = new-object System.Windows.Threading.DispatcherTimer 
        #Fire off every 1 minutes
        Write-Verbose "Adding 1 minute interval to timer object"
        $timer.Interval = [TimeSpan]"0:0:0.01"
        #Add event per tick
        Write-Verbose "Adding Tick Event to timer object"
        $timer.Add_Tick({
            $Mouse = [System.Windows.Forms.Cursor]::Position
            $MouseTracker_X_data_lbl.Content = $Mouse.x
            $MouseTracker_Y_data_lbl.Content = $Mouse.y    
        })
        #Start timer
        Write-Verbose "Starting Timer"
        $timer.Start()
        If (-NOT $timer.IsEnabled) {
            $Window.Close()
        }
    }) 


$MouseTracker.Add_Closed(
	{
        $Script:Timer.Stop()    
        [gc]::Collect()
        [gc]::WaitForPendingFinalizers()    
	}
)


$MouseTracker.Add_MouseLeftButtonDown(
	{
     $This.DragMove()
	}
)


$MouseTracker.Add_MouseRightButtonUp(
	{
   $This.close()
	}
)


