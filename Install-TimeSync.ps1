$DirectoryName="TimeSync"
$ScriptUri="https://raw.githubusercontent.com/StrajnarFilip/TimeSync/master/time.ps1"

Set-Location C:\
New-Item -ItemType Directory -Name $DirectoryName
Set-Location .\$DirectoryName
Invoke-WebRequest -Uri $ScriptUri -OutFile "time.ps1"

$newTaskAction = @{
    Execute = 'pwsh.exe'
    Argument = '-File "C:\TimeSync\time.ps1"'
}
$newTaskTrigger = @{
    AtLogOn  = $true
}
$registerTask = @{
    TaskName    = 'TimeSyncTask'
    Action      = New-ScheduledTaskAction @newTaskAction
    Trigger     = New-ScheduledTaskTrigger @newTaskTrigger
    RunLevel    = 'Highest'
    Description = 'Sync time'
}
Register-ScheduledTask @registerTask