function disable_defender_av()
{
    write-host `n"$(Get-Date -Format "yyyy/MM/dd HH:mm:ss"): Starting $($MyInvocation.ScriptName)"`r
    Set-MpPreference -DisableRealtimeMonitoring $true
    write-host "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss"): Completed $($MyInvocation.ScriptName)"`r
}
Write-Host "016: Started"
disable_defender_av
Write-Host "016: Ended"