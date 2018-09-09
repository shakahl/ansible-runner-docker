@echo off

docker run --rm -it -v %cd%/playbook:/ansible/playbook shakahl/ansible-runner bash %*
