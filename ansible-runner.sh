#!/bin/bash

docker run --rm -it -v ${PWD}/playbook:/ansible/playbook ansible-runner-docker bash %*
