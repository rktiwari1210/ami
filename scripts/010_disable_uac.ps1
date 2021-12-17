function disable_uac()
{
    New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force
}

Write-Host "010: Started"
disable_uac
Write-Host "010: Ended"


