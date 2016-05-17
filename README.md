# GitHubSandbox
Adam's Sandbox in Github

This is where I'm going to place the4 scripts for now.  Hopefully this works out.
###
Powershell scripts for TransitMaster Fixed
I’ve spent a lot of time working through the various parts of a software install and I’ve decided that windows powershell is a great tool to use to help us with this process.  This is a list of the scripts that I have to help with this.
Almost all of these are existing scripts that I found on the internet that I have tweaked.  I need some development time to go in and clean them up and complete all the TODO lists.
Step1CollectServerInfo.ps1
This script will get basic information about each machinename that it is passed and output a machinename.html file with all that information.  
TODO: 
1.	Better logging
2.	Make-item C:\TM_Backup\Scripts and copy output there
3.	Output file name should have include a timestamp

Step1CollectServerInfoV13.ps1
This is the same information gathering script, but it is for V13.  The only changes are that it looks in C:\Program Files (x86)\ILG\Transitmaster instead of C:\transitmaster

Step2TMBackup.ps1
Creates C:\TM_Backup\Backup-Datetime-randomNum and makes copies of the following directories to that dir "C:\TransitMaster", "C:\temp\ProgData_Transitmaster","C:\inetpub\WWWroot", "C:\Program Files (x86)\ILG\Transitmaster"
TODO:
Step3SoftwareDownload  – TBD – 
This will be a script to download the software files to the local machine $SourcePath.  I don’t have this made up just yet
Step4AppServerPatch.ps1
Stops services
Copies “app server” files from SourcePath to DestPath
\PREREQS
\server
\TMOnStreet
\Workstation

Starts services
Prints 50 newest Transitmaster messages from the event log in the script window.
TODO:
1.	Look to C:\TM_Backup\  
a.	IF there is not C:\TM_Backup\backup folder less than 24 hours old, launch backup script
Step5DataBaseUpdate – TBD- 
This will be a script to run all of the SQL scripts in the $SourcePath against the database machines.
Step6WorkstationPatch.ps1
Basically the same thing as step 4.  
Copies “workstation” patch files from SourcePath to DestPath

TODO: See Step4

Step7InstallTest.ps1
Launches the following apps with instructions on what to verify
TMDBConfiguration.exe
ClientMonitor.exe
TMConfiguration.exe
TMBusOPS.exe
ArrivalDepartures.exe
Logger_Monitor.exe

TODO: complete this list with all the apps that really need to be on here.

StartServices.ps1
Starts all services starting with TM and Trapeze in the correct order
TODO:

StopServices.ps1
Stops all services starting with TM and Trapeze in the correct order
TODO:

Powershell script Instructions
Copy the attached script locally to one of your servers.  In the example below I have placed the file in c:\TM_Temp\Scripts\Step1Collect-ServerInfo.ps1
Open windows powershell (as administrator) on one of the servers on the network 
Navigate to a directory that contains the script in the powershell window and run the following command.  Replace “dallas-app” and “dallas-db” with your machine names.    
PS C:\TM_Temp\Scripts> "Dallas-app", "Dallas-db" | .\Step1Collect-ServerInfo.ps1 -verbose 

If the script doesn’t run, you may need to set your execution policy to allow it
PS C:\TM_Temp\Scripts> Set-ExecutionPolicy RemoteSigned

PS C:\TM_Temp\Scripts> Get-ExecutionPolicy
RemoteSigned 

This is what the script will look like when it runs.
PS C:\TM_Temp\Scripts> "DAllas-app", "dallas-db" | .\Step1Collect-ServerInfo.ps1 -verbose
VERBOSE: Initializing
VERBOSE: =====> Processing DAllas-app <=====
VERBOSE: Collecting computer system information
VERBOSE: Collecting operating system information
VERBOSE: Collecting software information
VERBOSE: Collecting Services information (TM* and Trap* only)
VERBOSE: Collecting Event Log - Transitmaster - Newest 100
VERBOSE: Collecting logical disk information
VERBOSE: Collecting volume information
VERBOSE: Collecting network interface information
VERBOSE: Producing HTML report
VERBOSE: =====> Processing dallas-db <=====
VERBOSE: Collecting computer system information
VERBOSE: Collecting operating system information
VERBOSE: Collecting software information
VERBOSE: Collecting Services information (TM* and Trap* only)
VERBOSE: Collecting Event Log - Transitmaster - Newest 100
WARNING: The event log 'TransitMaster' on computer 'dallas-db' does not exist.
VERBOSE: Collecting logical disk information
VERBOSE: Collecting volume information
VERBOSE: Collecting network interface information
VERBOSE: Producing HTML report
VERBOSE: =====> Finished <=====

PS C:\TM_Temp\Scripts>  

The error on event log is perfectly fine, because the Database server wouldn’t have any transitmaster log files to be concerned about.
This will output a machinename.html file for each of the servers that you ran it against.  Once you have that complete, email the *.html files back to us.   I’ve included a sample (nash-app.html) file from one of our internal test machines as an example of what they should look like.
Also, this script does not currently get any information on SQL databases, so if you could please let us know what DB’s are installed on which machines, that would be helpful as well.

