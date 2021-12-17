function copy_cwp()
{
	$version = "$env:CWP_VERSION"
	$path = "D:\cwp\windows\$version"
	Write-Host "copying Symantec CWP Files from bps-aws-dev-s3-cwp-files -> $path"
	$bucket = "bps-aws-dev-s3-cwp-files"
	$keyPrefix = "windows/$version"

	Copy-S3Object -BucketName $bucket -KeyPrefix $keyPrefix -LocalFolder D:\cwp\windows\$version -AccessKey $env:AWS_ACCESS_KEY_ID -SecretKey $env:AWS_SECRET_KEY_ID -SessionToken $env:AWS_SESSION_TOKEN -Region $env:AWS_REGION
}
Write-Host "030: Started"
New-Item -ItemType Directory -Force -Path D:\cwp
New-Item -ItemType Directory -Force -Path D:\cwp\windows
New-Item -ItemType Directory -Force -Path D:\cwp\windows\$version
copy_cwp
Get-ChildItem -Path D:\cwp\windows -Recurse -Force
Write-Host "030: Ended"
