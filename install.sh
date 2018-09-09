#!/bin/bash

originalUser=$(who am i | awk '{print $1}')

baseUrl="https://raw.githubusercontent.com/shakahl/ansible-runner-docker/master"
installPath="/usr/local/bin/ansible-runner"
configDir="$HOME/.ansible"

echo "Ansible Runner Docker\n"

if [ ! -d $configDir ]; then
	mkdir -p $configDir
fi

if [ ! -f "$configDir/ansible.cfg" ]; then
    curl -o "$configDir/ansible.cfg" "$baseUrl/docker/etc/ansible/ansible.cfg"
fi

if [ ! -f "$configDir/hosts" ]; then
    curl -o "$configDir/hosts" "$baseUrl/docker/etc/ansible/hosts"
fi

chown -R $originalUser $configDir
chmod -R 0770 $configDir/*

curl -o "$installPath" "$baseUrl/ansible-runner.sh"
chmod 0775 "$installPath"

echo "Successfully installed: $installPath\n"

exit 0
