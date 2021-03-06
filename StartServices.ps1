#This is a function that lets me pause the script and wait for the user to press a key
Function pause ($message)
{
    # Check if running Powershell ISE
    if ($psISE)
    {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("$message")
    }
    else
    {
        Write-Host "$message" -ForegroundColor Yellow
        $x = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
}

Write-Host "Start TransitMaster and Trapeze Services v0.1"
Write-Host "This is a powershell script forstarting services in an organized fashion"
Write-Host "This will display the current t* services, and then start them backup, while showing you the steps along the way"
Write-Host "At the end of the process, it will launch Event log and let you verify the process as well"
Write-Host "Note:There is a known bug where TMRouter logs will not be seen in windows event log 2.24.16"

get-service t*| ft -auto
pause "Press enter to start services"
Write-Host "Starting services now, please wait."

Start-service TMAppDataService           
Start-service TMRouter                   
Start-service TMLogger                   
Start-service TMCalc                     
Start-service TMMcc                      
Start-service TMOpsCommSvr               
Start-service TMWorkAssignments          
Start-service TMDataCubeService          
Start-service TMDataStagingService       
Start-service TMTracker                  
Start-service TMHealthMonitorSvr
Start-service tm*
Start-service Trapeze* 
Write-Host "Services have been started"

pause "Press Enter to continue"
Write-Host "Displaying services"
get-service t*| ft -auto

pause "Services Restarted, press enter to finish"
