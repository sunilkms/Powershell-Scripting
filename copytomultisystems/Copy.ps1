#Type Source Folder Name
$FiletoCopyFrom = "C:\Temp"

# Type the name of the folder you want to be created on the destenation machine
# this folder will be force created if already exist will be overwritten.
$DestinationFolderName = "Temp" 

#type the Drive Letter you want the file to be copied.
$DestinationDriveLetter = "C$"

# Provide the file path where the Server List is stored.
$MachineListFileName = "C:\temp\ServerList.txt"

#----------Script start--------------------------------------

$DestinationMachines= Get-Content $MachineListFileName
$items = Get-ChildItem $FiletoCopyfrom
foreach ($Server in $DestinationMachines) 
        {
         Write-host "
         Working on Server:" $Server -f Green        
         New-Item -Path "\\$Server\$DestinationDriveLetter\" -Name $destinationFolderName-ItemType Directory -Force -Verbose
         foreach ($file in $items )
                 {      
                  Copy-Item -Path $file.FullName -Destination "\\$Server\$DestinationDriveLetter\$DestinationFolderName\" -Force -Verbose
                 }   
         }
