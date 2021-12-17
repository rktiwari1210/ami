function install_ssm()
{
    $response = Invoke-WebRequest "https://s3.us-east-1.amazonaws.com/amazon-ssm-us-east-1/latest/VERSION"
    Write-Host "Latest  SSM Agent version is $response"
    $ssmver = (Get-CimInstance Win32_Product | Where-Object {$_.Name -eq 'Amazon SSM Agent'} | Select-Object -ExpandProperty Version)
    Write-Host "Current SSM Agent version is $ssmver"
    if ($response -eq $ssmver)
    {
        Write-Host "Base Image has the latest SSM agent version"
    }
    else {
        Write-Host "Base AWS Image does not have the latest SSM agent version, upgrading Gold Image to the latest SSM agent version $response"
        Invoke-WebRequest https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/windows_amd64/AmazonSSMAgentSetup.exe -OutFile $env:USERPROFILE\Desktop\SSMAgent_latest.exe
        $process = Start-Process -FilePath $env:USERPROFILE\Desktop\SSMAgent_latest.exe -ArgumentList "/S /quiet /norestart" -Wait -PassThru
        do{Start-Sleep 1}while(Get-Process -Id $process.Id -Ea SilentlyContinue)
        Remove-Item -Force $env:USERPROFILE\Desktop\SSMAgent_latest.exe
    }
}
Write-Host "Started install/update SSM agent Script"
install_ssm
Write-Host "Ended install/update SSM agent Script"