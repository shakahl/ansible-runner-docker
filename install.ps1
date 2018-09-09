
Set-ExecutionPolicy Bypass -Scope Process -Force

$installDir = "C:\Users\$($env:username)\Appdata\Local\ansible-runner"
$scriptFile = "$installDir\ansible-runner.cmd"

Write-Output "Install dir: $installDir"
Write-Output "Install file: $scriptFile"


Write-Output "Ensuring folder exists: $installDir"

If(!(test-path $installDir))
{
  New-Item -ItemType Directory -Force -Path $installDir
}

# Download the script
Invoke-Expression -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/shakahl/ansible-runner-docker/master/ansible-runner.cmd', '$scriptFile')"

# PowerShell 3+?
#iwr https://raw.githubusercontent.com/shakahl/ansible-runner-docker/master/install.ps1 -UseBasicParsing | iex

Write-Output 'Ensuring commands are on the path'

if ($($env:Path).ToLower().Contains($($installDir).ToLower()) -eq $false) {
  #$env:Path = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User)
  $pathElements = @([Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User) -split ";")
  $pathElements += $installDir
  $newPath = $pathElements -join ";"
  [Environment]::SetEnvironmentVariable('Path', $newPath, [System.EnvironmentVariableTarget]::User)
  $env:Path = $newPath
}


(Get-Command 'docker' | Select-Object -ExpandProperty Definition | Tee-Object -Variable dockerCmd)

$dockerCmd -replace ' ', '` '

# Pulling docker image
Invoke-Expression -Command "'$dockerCmd  pull shakahl/ansible-runner-docker'"

