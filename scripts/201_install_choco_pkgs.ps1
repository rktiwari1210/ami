function install_chocolatey() {
    $testchoco = powershell choco -v
    if(-not($testchoco)){
        Write-Output "Seems Chocolatey is not installed, installing now"
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
    else{
        Write-Output "Chocolatey Version $testchoco is already installed"
    }
}

function install_curl() {
    choco install curl -y --ignore-package-exit-codes
}

function install_powershell_tools() {
    choco install awstools.powershell -y --ignore-package-exit-codes
}

function install_dotnetfx() {
    choco install dotnetfx -y --ignore-package-exit-codes
}

function install_dotnetcore() {
    choco install dotnetcore-runtime.install --version=3.1.4 -y --params="Quiet Skip32Bit" --ignore-package-exit-codes
}

function install_sqlserver-cmdlineutils() {
    choco install sqlserver-cmdlineutils -y --ignore-package-exit-codes
}

function install_sqlserver-odbcdriver() {
    choco install sqlserver-odbcdriver -y --ignore-package-exit-codes
}

function install_powershell_7() {
    choco install powershell-core -y --ignore-package-exit-codes
}

Write-Host "201: Started"
install_chocolatey
install_curl
install_powershell_7
install_powershell_tools
install_dotnetfx
install_dotnetcore
install_sqlserver-cmdlineutils
install_sqlserver-odbcdriver

Write-Host "201: Ended"