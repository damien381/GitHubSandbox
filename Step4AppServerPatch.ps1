#####################################################################
###   Step4AppServerPatch.ps1                                     ###
###   By: Adam Hoge - Trapeze Project Engineer                    ###
###   Copy files from the patch directory to C:\transitmaster     ###
###   It's not perfect, but I like it.                            ###
#####################################################################

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

#Setup where the software is at and where it is going

$SourcePath="C:\TM_Backup\Software\22S2000-015 Gen II Release v15.1.4.2 (04-26-2016)"
$DestPath="C:\Transitmaster"

# I search for any MSI files and install them if they need them
# TMTrapezeOpsInterface is there but we don't need it.

pause "Press enter to stop services"
#############################################
#Stop the services
Write-Host "Stopping services now, please wait."
Stop-Service TM* -exclude TMAppDataService 
Stop-Service Trapeze*
Stop-Service TMAppDataService

Write-Host "Services have been stopped"

#############################################


Write-Host "patching C:\Transitmaster"

copy-item $sourcepath\PREREQS\* $DestPath -force -recurse

Write-Host "PREREQS files have been patched"

copy-item $sourcepath\server\* $DestPath -force -recurse

Write-Host "Server files have been patched"

copy-item $sourcepath\TMOnStreet\* $DestPath -force -recurse

Write-Host "TMOnStreet files have been patched"

copy-item $sourcepath\Workstation\* $DestPath -force -recurse

Write-Host "Workstation files have been patched"
#############################################
Write-Host "Finished patching C:\Transitmaster"

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
Write-Host "Displaying eventlog for Transitmaster"
Get-EventLog -LogName TransitMaster -Newest 50

pause "Services Restarted, press enter to finish and launch event logger"
Write-Host "Displaying eventlog for Transitmaster"