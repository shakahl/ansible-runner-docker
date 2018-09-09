
Set-ExecutionPolicy Bypass -Scope Process -Force

$baseUrl = "https://raw.githubusercontent.com/shakahl/ansible-runner-docker/master"
$installDir = "$($env:appdata)\ansible-runner"
$scriptFile = "$installDir\ansible-runner.cmd"

$configDir = "$($env:userprofile)\.ansible"

Write-Output "Config dir: $configDir"
Write-Output "Install dir: $installDir"
Write-Output "Install file: $scriptFile"


Write-Output "Ensuring install directory exists: $installDir"

If(!(test-path $installDir))
{
  New-Item -ItemType Directory -Force -Path $installDir
}

Write-Output "Ensuring configuration directory exists: $configDir"

If(!(test-path $configDir))
{
  New-Item -ItemType Directory -Force -Path $configDir
}

If(!(test-path "$configDir\ansible.cfg"))
{
  Write-Output "Creating: $configDir\ansible.cfg"
  Invoke-Expression -Command "(New-Object System.Net.WebClient).DownloadFile('$baseUrl/docker/etc/ansible/ansible.cfg', '$configDir\ansible.cfg')"
}

If(!(test-path "$configDir\hosts"))
{
  Write-Output "Creating: $configDir\hosts"
  Invoke-Expression -Command "(New-Object System.Net.WebClient).DownloadFile('$baseUrl/docker/etc/ansible/hosts', '$configDir\hosts')"
}

# Download the script
Invoke-Expression -Command "(New-Object System.Net.WebClient).DownloadFile('$baseUrl/ansible-runner.cmd', '$scriptFile')"

# PowerShell 3+?
#iwr https://raw.githubusercontent.com/shakahl/ansible-runner-docker/master/install.ps1 -UseBasicParsing | iex

Write-Output 'Ensuring commands are on the path'

if ($($env:Path).ToLower().Contains($($installDir).ToLower()) -eq $false) {
  [Environment]::SetEnvironmentVariable
    ( "Path", $env:Path + ";$installDir", [System.EnvironmentVariableTarget]::User )
}


(Get-Command 'docker' | Select-Object -ExpandProperty Definition | Tee-Object -Variable dockerCmd)

$dockerCmd -replace ' ', '` '

# Pulling docker image
Invoke-Expression -Command "'$dockerCmd pull shakahl/ansible-runner-docker'"


