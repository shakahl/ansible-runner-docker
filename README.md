ansible-runner-docker
=============================

[![Docker Stars](https://img.shields.io/docker/stars/shakahl/ansible-runner-docker.svg)](https://hub.docker.com/r/shakahl/ansible-runner-docker/)
[![Docker Pulls](https://img.shields.io/docker/pulls/shakahl/ansible-runner-docker.svg)](https://hub.docker.com/r/shakahl/ansible-runner-docker/)
[![Docker Automated build](https://img.shields.io/docker/automated/shakahl/ansible-runner-docker.svg)](https://hub.docker.com/r/shakahl/ansible-runner-docker/builds/)
[![Build Status](https://travis-ci.org/shakahl/ansible-runner-docker.svg?branch=master)](https://travis-ci.org/shakahl/ansible-runner-docker)

## Installation

### On Windows

**Command line**

```batch
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/shakahl/ansible-runner-docker/master/install.ps1'))" && SET "PATH=%PATH%;%APPDATA%\ansible-runner\ansible-runner.cmd"
```

**PowerShell**

```ps
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/shakahl/ansible-runner-docker/master/install.ps1'))
```

### On Linux

curl method:
```bash
#!/bin/bash
curl -sL https://raw.githubusercontent.com/shakahl/ansible-runner-docker/master/install.sh | sudo bash -
```

wget method:
```bash
#!/bin/bash
wget -O - https://raw.githubusercontent.com/shakahl/ansible-runner-docker/master/install.sh | sudo bash
```

## Configuration

### Playbook path

Default playbook path is `<current dir>/playbook`

You can override the playbook path via environment variable `PLAYBOOK_PATH`.

### Ansible configuration

The installer creates `.ansible` directory under the HOME. It places default configuration if not exits.

## Usage

### On Windows

```bash
ansible-runner.cmd
```

```bash
ansible-runner.cmd -i all playbook/playbook.yml
```

### On Linux

```bash
ansible-runner
```

```bash
ansible-runner -i all playbook/playbook.yml
```

## Resources

* https://alpinelinux.org/
* http://ansible.com
