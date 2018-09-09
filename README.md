ansible-runner-docker
=============================

[![Docker Stars](https://img.shields.io/docker/stars/shakahl/ansible-runner.svg)](https://hub.docker.com/r/shakahl/ansible-runner/)
[![Docker Pulls](https://img.shields.io/docker/pulls/shakahl/ansible-runner.svg)](https://hub.docker.com/r/shakahl/ansible-runner/)
[![Docker Automated build](https://img.shields.io/docker/automated/shakahl/ansible-runner.svg)](https://hub.docker.com/r/shakahl/ansible-runner/builds/)
[![Build Status](https://travis-ci.org/shakahl/ansible-runner.svg?branch=master)](https://travis-ci.org/shakahl/ansible-runner)

## Usage

### Windows

```batch
@echo off

docker run --rm -it -v %cd%/playbook:/ansible/playbook shakahl/ansible-runner bash %*

```

### Linux

```bash
#!/bin/bash

docker run --rm -it -v ${PWD}/playbook:/ansible/playbook ansible-runner bash %*

```

## Resources
* https://alpinelinux.org/
* http://ansible.com
