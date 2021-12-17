function install_awscli {
        $command = "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12"
        Invoke-Expression $command
        Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -Outfile C:\AWSCLIV2.msi
        $arguments = "/i `"C:\AWSCLIV2.msi`" /quiet"
        Start-Process msiexec.exe -ArgumentList $arguments -Wait
}

Write-Host "Install AWSCLI: Started"
install_awscli
Write-Host "Install AWSCLI: Finished"