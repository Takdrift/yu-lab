# record the log
Start-Transcript -path d:\Shao\Web\FileSystemWatcher\FileSystemWatcherLog.txt -Force -Append -NoClobber

# make sure you adjust this to point to the folder you want to monitor
Write-Host "Start monitoring @ $(Get-Date)"
$PathToMonitor = "D:\Shao\Web\yu-lab\content\"

# monitoring time interval, s
$timeout = 1
$timewait=30

# explorer $PathToMonitor

$FileSystemWatcher = New-Object System.IO.FileSystemWatcher
$FileSystemWatcher.Path  = $PathToMonitor
$FileSystemWatcher.IncludeSubdirectories = $true

# make sure the watcher emits events
$FileSystemWatcher.EnableRaisingEvents = $true

Write-Host "Watching for changes to $PathToMonitor"
Write-Host "Monitoring interval: $timeout sec"
Write-Host "Time wait after deploy: $timewait sec"

while ($true) {
  # sleep $timeout
  # monitoring all files and folders
  $result = $FileSystemWatcher.WaitForChanged('all',1000)
  if ($result.TimedOut -eq $false)
   {
   # show text when a change was detected
    Write-Warning ('File {0} : {1} @ {2}' -f $result.ChangeType, $result.name, (Get-Date)) 
   # run the .bat file
   cmd.exe /c 'D:\Shao\Web\yu-lab\render_public.bat'
   # after deploy the blog
   Write-Host "Blog updated @ $(Get-Date)"
   sleep $timewait
   }
} 
