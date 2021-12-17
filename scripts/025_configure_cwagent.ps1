function configure_cwagent()
{
	if (Get-Service "AmazonCloudWatchAgent" -ErrorAction SilentlyContinue)
    {
        Write-Host "Service AmazonCloudWatchAgent Exist"
		#Copy config file to the CW path & start the cw agent service
		Copy-Item "C:\temp\scripts\config.json" -Destination "C:\Program Files\Amazon\AmazonCloudWatchAgent\config.json" -Recurse
		Copy-S3Object -bucketname bps-aws-dev-s3-cloudwatch-monitor -KeyPrefix generic/ -LocalFolder "C:\Program Files\Amazon\AmazonCloudWatchAgent" -AccessKey $env:AWS_ACCESS_KEY_ID -SecretKey $env:AWS_SECRET_KEY_ID -SessionToken $env:AWS_SESSION_TOKEN -Region $env:AWS_REGION
		Set-Location -Path 'C:\Program Files\Amazon\AmazonCloudWatchAgent\'
		.\amazon-cloudwatch-agent-ctl.ps1 -a fetch-config -m ec2 -c file:'C:\Program Files\Amazon\AmazonCloudWatchAgent\config.json' -s
    }
    else
    {
		$parameters = @{
		Uri = 'https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/AmazonCloudWatchAgent.zip'
		OutFile = "$env:TEMP\AmazonCloudWatchAgent.zip"
		}
		Invoke-WebRequest @parameters
		Expand-Archive -Path "$env:TEMP\AmazonCloudWatchAgent.zip" -DestinationPath "$env:TEMP\AmazonCloudWatchAgent"
		# Run PS script for CW agent installation
		Set-Location -Path "$env:TEMP\AmazonCloudWatchAgent"
		.\install.ps1
		#Copy config file to the CW path & start the cw agent service
		Copy-Item "C:\temp\scripts\config.json" -Destination "C:\Program Files\Amazon\AmazonCloudWatchAgent\config.json" -Recurse
		Copy-S3Object -bucketname bps-aws-dev-s3-cloudwatch-monitor -KeyPrefix generic/ -LocalFolder "C:\Program Files\Amazon\AmazonCloudWatchAgent" -AccessKey $env:AWS_ACCESS_KEY_ID -SecretKey $env:AWS_SECRET_KEY_ID -SessionToken $env:AWS_SESSION_TOKEN -Region $env:AWS_REGION
		Set-Location -Path 'C:\Program Files\Amazon\AmazonCloudWatchAgent\'
		.\amazon-cloudwatch-agent-ctl.ps1 -a fetch-config -m ec2 -c file:'C:\Program Files\Amazon\AmazonCloudWatchAgent\config.json' -s
	}

}

Write-Host "025: Started"
configure_cwagent
Write-Host "025: Ended"