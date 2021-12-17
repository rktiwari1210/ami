function initialize_disk() {
	$tmppath = "c:\temp\scripts"
	Set-Location -Path $tmppath
	If (!(Test-Path D:))
	{
		Get-ChildItem -Path C:\temp\scripts -Force
		Write-Host "00: Initializing Disk and Setting Drive Letter"
		Invoke-Expression -Command "cmd.exe /c 'diskpart /s diskpart.txt'"
	}
    else
	{
		Write-Host "00: Volume D: exists"
	}
}

Write-Host "000: Started"
initialize_disk
Write-Host "000: Ended"