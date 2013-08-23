# This code copies new files greater than a specific date 
# from the source folder and assumes that the existing files are not updated. 
# to run from cmd: powershell -File <Filename>

# variables 
$SrcDir = 'C:\source'
$DestDir = 'C:\dest\OIT_Files'
# empty hash table
$ht = @{}

# Get the last time stamp from log file 
$LastDate = Get-Content C:\dest\LogTimeStamp.txt

# Get all files greater than $LastDate and copy to dest
Get-ChildItem -Recurse $SrcDir | Where-Object{$_.LastWriteTime -gt $LastDate} | Copy-Item -Destination $DestDir

# load lastwritetime to hash table
Get-ChildItem -Recurse $SrcDir | sort lastwritetime | foreach { $ht[$_.Extension] = $_.LastWriteTime} 

# Clear and update the time stamp
Clear-Content C:\dest\LogTimeStamp.txt

# Add the latest time stamp to log file
Add-Content  C:\dest\LogTimeStamp.txt  ($ht.GetEnumerator() | Sort value -Descending | select -First 1).Value



