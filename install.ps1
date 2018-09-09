
$installDir = "C:\Users\$($env:username)\Appdata\Local\ansible-runner"
$scriptFile = "$($installDir)\ansible-runner.cmd"

Write-Output "Install dir: $installDir"
Write-Output "Install file: $scriptFile"

Set-ExecutionPolicy Bypass -Scope Process -Force

# function Fix-PowerShellOutputRedirectionBug {
#   $poshMajorVerion = $PSVersionTable.PSVersion.Major

#   if ($poshMajorVerion -lt 4) {
#     try{
#       # http://www.leeholmes.com/blog/2008/07/30/workaround-the-os-handles-position-is-not-what-filestream-expected/ plus comments
#       $bindingFlags = [Reflection.BindingFlags] "Instance,NonPublic,GetField"
#       $objectRef = $host.GetType().GetField("externalHostRef", $bindingFlags).GetValue($host)
#       $bindingFlags = [Reflection.BindingFlags] "Instance,NonPublic,GetProperty"
#       $consoleHost = $objectRef.GetType().GetProperty("Value", $bindingFlags).GetValue($objectRef, @())
#       [void] $consoleHost.GetType().GetProperty("IsStandardOutputRedirected", $bindingFlags).GetValue($consoleHost, @())
#       $bindingFlags = [Reflection.BindingFlags] "Instance,NonPublic,GetField"
#       $field = $consoleHost.GetType().GetField("standardOutputWriter", $bindingFlags)
#       $field.SetValue($consoleHost, [Console]::Out)
#       [void] $consoleHost.GetType().GetProperty("IsStandardErrorRedirected", $bindingFlags).GetValue($consoleHost, @())
#       $field2 = $consoleHost.GetType().GetField("standardErrorWriter", $bindingFlags)
#       $field2.SetValue($consoleHost, [Console]::Error)
#     } catch {
#       Write-Output "Unable to apply redirection fix."
#     }
#   }
# }

# Fix-PowerShellOutputRedirectionBug

# Check install folder

Write-Output "Ensuring folder exists: $installDir"
If(!(test-path $installDir))
{
  New-Item -ItemType Directory -Force -Path $installDir
}

#if (![System.IO.Directory]::Exists($installDir))
#{
#  [System.IO.Directory]::CreateDirectory($installDir);
#}

# Download the script
iex ((New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/shakahl/ansible-runner-docker/master/ansible-runner.cmd', $scriptFile))
# PowerShell 3+?
#iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

Write-Output 'Ensuring commands are on the path'

if ($($env:Path).ToLower().Contains($($installDir).ToLower()) -eq $false) {
  #$env:Path = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User)
  $pathElements = @([Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User) -split ";")
  $pathElements += $installDir
  $newPath = $pathElements -join ";"
  [Environment]::SetEnvironmentVariable('Path', $newPath, [System.EnvironmentVariableTarget]::User)
  $env:Path = $newPath
}


# Pulling docker image
docker pull "shakahl/ansible-runner-docker"

