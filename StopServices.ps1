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

Write-Host "Stop TransitMaster and Trapeze Services v0.1"
Write-Host "This is a powershell script for stopping services in an organized fashion"
Write-Host "This will display the current t* services, stop them and show you the steps along the way"
Write-Host "At the end of the process, it will launch Event log and let you verify the process as well"
Write-Host "Note:There is a known bug where TMRouter logs will not be seen in windows event log 2.24.16"

get-service t*| ft -auto
#Stop all the TM* Services, Trapeze services and finally TMAppDataStore
pause "Press enter to stop services"
Write-Host "Stopping services now, please wait."
Stop-Service TM* -exclude TMAppDataService 
Stop-Service Trapeze*
Stop-Service TMAppDataService

Write-Host "Services have been stopped"
get-service t*| ft -auto

pause "Services stopped, press enter to finish"
