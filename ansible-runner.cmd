@echo off

set PLAYBOOK_DIR="%PLAYBOOK_DIR%"

if %PLAYBOOK_DIR%=="" (
	set PLAYBOOK_DIR="%cd%/playbook"
)

IF not exist %PLAYBOOK_DIR% (
	mkdir "%PLAYBOOK_DIR%"
)

set ANSIBLE_RUNNER_USERCONFIG="%ANSIBLE_RUNNER_USERCONFIG%"

if %ANSIBLE_RUNNER_USERCONFIG%=="" (
	set ANSIBLE_RUNNER_USERCONFIG="%USERPROFILE%/.ansible"
)

IF not exist %ANSIBLE_RUNNER_USERCONFIG% (
	mkdir "%ANSIBLE_RUNNER_USERCONFIG%"
)

docker run --rm -it -v "%PLAYBOOK_DIR%:/ansible/playbook" -v "%ANSIBLE_RUNNER_USERCONFIG%:/ansible/.ansible" shakahl/ansible-runner-docker bash %*
