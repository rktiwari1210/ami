function install_jdk7()
{
    Copy-S3Object -bucketname bps-aws-dev-s3-cis-software -KeyPrefix java7/ -LocalFolder "C:\temp\" -AccessKey $env:AWS_ACCESS_KEY_ID -SecretKey $env:AWS_SECRET_KEY_ID -SessionToken $env:AWS_SESSION_TOKEN -Region $env:AWS_REGION
    Set-Location -Path 'C:\temp'
    $args = "/c jdk-7u79-windows-x64.exe /s /qn"
    $Prog = Start-Process cmd.exe -ArgumentList $args -Wait -PassThru
    do{Start-Sleep 1}while(Get-Process -Id $Prog.Id -Ea SilentlyContinue)
}

Write-Host "202: Started"
install_jdk7
Write-Host "202: Ended"