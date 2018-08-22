

@echo off

docker run --rm -it -v %cd%/playbook:/ansible/playbook ansible-runner bash %*
