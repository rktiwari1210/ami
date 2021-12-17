function install_winfeature()
{
    Install-WindowsFeature -name Web-Server -IncludeManagementTools
    Add-WindowsFeature NET-Framework-45-Features
    Add-WindowsFeature NET-Framework-45-Core
    Add-WindowsFeature NET-Framework-45-ASPNET
}

Write-Host "200: Started"
install_winfeature
Write-Host "200: Ended"