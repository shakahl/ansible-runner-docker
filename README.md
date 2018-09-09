ansible-runner-docker
=============================

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

