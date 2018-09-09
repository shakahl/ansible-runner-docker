ansible-runner-docker
=============================

[![Docker Stars](https://img.shields.io/docker/stars/shakahl/ansible-runner-docker.svg)](https://hub.docker.com/r/shakahl/ansible-runner-docker/)
[![Docker Pulls](https://img.shields.io/docker/pulls/shakahl/ansible-runner-docker.svg)](https://hub.docker.com/r/shakahl/ansible-runner-docker/)
[![Docker Automated build](https://img.shields.io/docker/automated/shakahl/ansible-runner-docker.svg)](https://hub.docker.com/r/shakahl/ansible-runner-docker/builds/)
[![Build Status](https://travis-ci.org/shakahl/ansible-runner-docker.svg?branch=master)](https://travis-ci.org/shakahl/ansible-runner-docker)

## Usage

### Windows

```batch
@echo off

docker run --rm -it -v %cd%/playbook:/ansible/playbook shakahl/ansible-runner-docker bash %*

```

### Linux

```bash
#!/bin/bash

docker run --rm -it -v ${PWD}/playbook:/ansible/playbook ansible-runner-docker bash %*

```

## Resources
* https://alpinelinux.org/
* http://ansible.com
