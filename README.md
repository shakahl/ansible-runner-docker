ansible-runner-docker
=============================

[![Docker Stars](https://img.shields.io/docker/stars/shakahl/ansible-runner-docker.svg)](https://hub.docker.com/r/shakahl/ansible-runner-docker/)
[![Docker Pulls](https://img.shields.io/docker/pulls/shakahl/ansible-runner-docker.svg)](https://hub.docker.com/r/shakahl/ansible-runner-docker/)
[![Docker Automated build](https://img.shields.io/docker/automated/shakahl/ansible-runner-docker.svg)](https://hub.docker.com/r/shakahl/ansible-runner-docker/builds/)
[![Build Status](https://travis-ci.org/shakahl/ansible-runner-docker.svg?branch=master)](https://travis-ci.org/shakahl/ansible-runner-docker)

## Usage

### Windows

**Command line**

```batch
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/shakahl/ansible-runner-docker/master/install.ps1'))" && SET "PATH=%PATH%;%USERNAME%\Appdata\Local\ansible-runner\ansible-runner.cmd"
```

**PowerShell**

```ps
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/shakahl/ansible-runner-docker/master/install.ps1'))
```

### Linux

```bash
#!/bin/bash

echo "TODO"

```

## Resources
* https://alpinelinux.org/
* http://ansible.com
