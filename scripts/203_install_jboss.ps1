function install_jboss()
{
      Copy-S3Object -bucketname bps-aws-dev-s3-cis-software -KeyPrefix java/ -LocalFolder "C:\temp\" -AccessKey $env:AWS_ACCESS_KEY_ID -SecretKey $env:AWS_SECRET_KEY_ID -SessionToken $env:AWS_SESSION_TOKEN -Region $env:AWS_REGION
      start-sleep -s 20
      $source = "C:\temp\jboss-5.1.0.GA-jdk6.zip"
      $destination = "C:\temp\jboss-5.1.0.GA-jdk6"
      Expand-Archive $source -DestinationPath $destination
      Set-Location -Path 'C:\temp\jboss-5.1.0.GA-jdk6\jboss-5.1.0.GA\bin'
      get-childitem C:\temp\jboss-5.1.0.GA-jdk6\jboss-5.1.0.GA\bin
      $args = "/c service.bat install"
      $Prog = Start-Process cmd.exe -ArgumentList $args -Wait -PassThru
      do{Start-Sleep 1}while(Get-Process -Id $Prog.Id -Ea SilentlyContinue)
}

Write-Host "203: Started"
install_jboss
Write-Host "203: Ended"