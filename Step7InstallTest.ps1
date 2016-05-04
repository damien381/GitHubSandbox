## Test the install
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

$AppPath="C:\TransitMaster\"

& $apppath\TMDBConfiguration.exe
pause "Launching TMDBConfiguration.  Please test connections for all green lights and press OK once completed"

& $apppath\ClientMonitor.exe
pause "Launching ClientMonitor.  Please Verify TMRouter sees what it should, and press OK once completed"

& $apppath\TMConfiguration.exe
pause "Launching TMConfiguration.  Please Verify that database values are present in the Fleet, and press OK once completed"

& $apppath\TMBusOPS.exe
pause "Launching TMTMBusOPS.  Verify routes and stops show up and other functionality. Press OK once completed"

& $apppath\ArrivalDepartures.exe  #Why doesn't that work?
pause "Launching ArrivalDepartures.  Verify routes and stops show up and other functionality. Press OK once completed"

& $apppath\Logger_Monitor.exe  #Why don't I see mininet
pause "Launching Logger_Monitor.exe. Verify MiniNet messages are coming from TMRouter. Press OK once completed"


