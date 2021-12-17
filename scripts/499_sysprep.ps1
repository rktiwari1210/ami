function ami_sysprep() 
{ 
    $jobtime0 = Get-Date -Format "dddd MM/dd/yyyy HH:mm:ss K"
    Write-Host "70: InitializeInstance.ps1 started at $jobtime0"
    Invoke-Expression "&'C:\ProgramData\Amazon\EC2-Windows\Launch\Scripts\InitializeInstance.ps1' -Schedule"
    $jobtime1 = Get-Date -Format "dddd MM/dd/yyyy HH:mm:ss K"
    Write-Host "70: SysprepInstance.ps1 started at $jobtime1"
    Invoke-Expression "&'C:\ProgramData\Amazon\EC2-Windows\Launch\Scripts\SysprepInstance.ps1' -NoShutdown" 
    $jobtime2 = Get-Date -Format "dddd MM/dd/yyyy HH:mm:ss K"
    Write-Host "70: SysprepInstance.ps1 finished at $jobtime2"
}

Write-Host "499: Started Sysprep Script"
ami_sysprep
Write-Host "499: Ended Sysprep Script"