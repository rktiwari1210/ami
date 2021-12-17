function disable_defender_fw ()
{
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
}
Write-Host "015: Started"
disable_defender_fw
Write-Host "015: Ended"
