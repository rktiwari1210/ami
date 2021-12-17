function extract_zip_files() 
{

	Expand-Archive -Path "d:\cwp\windows\$version\scwp_agent_windows_package_6.8.2.67.zip" -DestinationPath ${dpath}
	start-sleep -s 15
}

Write-Host "035: Started"
$version = "$env:CWP_VERSION"
$dpath = "D:\cwp\windows\$version"
New-Item -ItemType Directory -Force -Path ${dpath}
extract_zip_files
Write-Host "035: Ended"