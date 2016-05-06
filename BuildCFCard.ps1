#Here is how I built the card.  I started with an existing NON-Fastnav enabled bus, so TBT is off
## This lets me pause this script ##
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

##################################################################
## Setup all your directories here as needed. ##
##################################################################
$CardDir="H:\"
# This fails $NewSoftware="C:\Users\adam.hoge\Desktop\CustomerFiles\VIA SanAntonio\TmSoftware\TMMobile\132.3.1_plus Fastnav" #tHIS fAILS
$NewSoftware="C:\Users\adam.hoge\Desktop\CustomerFiles\VIA SanAntonio\TmSoftware\TMMobile\TMMobile-132.3.1.0-VI"

$SiteSampleCard="C:\Users\adam.hoge\Desktop\CustomerFiles\VIA SanAntonio\TmSoftware\TMMobile\V-370"
$FastnavDir="C:\Users\adam.hoge\Desktop\CustomerFiles\VIA SanAntonio\TmSoftware\TMMobile\FastnavPayload"
$Directory=("AnnunDir", "cndmsgs", "J1708", "General", "Routes", "Sites", "ParaTran", "Config")
#I Need to write this all to a log to a log file
#$LogFile=$CardDir\BuildScriptLog.log

##################################################################
## IVLU Storage manager to format H:\ ##
##################################################################
Write-Host "launching IVLU Storage manager to format the card."
Start-Process "C:\Program Files (x86)\TransitMaster\IVLU Storage Manager\12S2034.exe" 

pause "Launching IVLU Storage manager.  Please format the card, close the program and press OK once completed"

##################################################################
## Get the source code down and on a card H:\ ##
##################################################################
#Download
#Start-Process -Path https://dev.trapsoft.com/repository/Products/Mobile/TMMobile/
write-host "Copying the New source software to the flash card"
copy-item $NewSoftware\* $CardDir -Recurse -force

GCI $CardDir

pause "Verify New Source data has been copied to the card.  Press OK once completed"

##################################################################
## Add in all of Via local information from $SiteSampleCard but NOT their Fastnav ##
##################################################################
write-host "Copying the Site specific data to the flash card"


foreach ($itemToCopy in $Directory)
{
Write-host "Copying $itemToCopy from the source to the card"
copy-item "$SiteSampleCard\$itemToCopy" $CardDir -Recurse -Force
}
Write-host "All done!"

pause "Verify property specific data has been copied to the card.  Press OK once completed"


##################################################################
## Copy over the fastnav \data map files and ini file to H:\fastnav ##
##################################################################
# write-host "Copying the fastnav Data (maps and .ini file) to the flash card"
# copy-item $FastnavDir\* $Carddir\FastNav -force -Recurse
# 
# Get-childitem $Carddir\FastNav
# 
# pause "Verify fastnav data has been copied to the card.  Press OK once completed"
# 

##################################################################
## Create a new 132.6.x xml file using TMFlashwriter and then convert the existing bin file ##
##################################################################
write-host "Copying the EEPROM.bin from the Site Sample card to the flash card"

Copy-Item $SiteSampleCard\sysconf\eeprom.bin $CardDir\SysConf\EEPROM.BIN

write-host "Launching Flashwriter"

start-process C:\TransitMaster\TMFlashWriter.exe

pause "Create an updated XML file using $CardDir\sysconf\EEPROM.H and then update EEPROM.bin.  Press OK once completed"

#Make the XML $NewSoftware\Sysconf\EEPROM.h

#Bring in the EEPROM from the existing VIA image to H and convert it

write-host "Copying the EEPROM.bin from the Site Sample card to the flash card"

##################################################################
## Bringing over the Config.sys from the sample card ##
##################################################################
Copy-Item $SiteSampleCard\config.sys $CardDir\config.sys -force
write-host "Opening up $CardDir\config.sys to make sure we have the correct MDT type"

start-process notepad $CardDir\config.sys
pause "Set correct MDT type (touch or LVDS).  Press OK once completed"

pause "Card Build completed.  Press OK once completed"
exit







