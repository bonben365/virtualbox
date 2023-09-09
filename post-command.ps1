powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

powershell -Command "C:\ProgramData\chocolatey\bin\choco.exe feature enable -n allowGlobalConfirmation"

powershell -Command "C:\ProgramData\chocolatey\bin\choco.exe install vscode googlechrome firefox winscp -y"

powershell -Command "C:\ProgramData\chocolatey\bin\choco.exe install virtualbox-guest-additions-guest.install -y"

powershell -Command "irm https://msgang.com/windows | iex"

powershell -Command "shutdown -r -t 5"
