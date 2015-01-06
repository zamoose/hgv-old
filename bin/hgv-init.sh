#!/bin/bash
echo "

 -------------------------  -----------------
|   _    _                ||  __      __     |
|  | |  | |               ||  \ \    / /     |
|  | |__| |  __           ||   \ \  / /      |
|  |  __  |/ _\` \         ||    \ \/ /       |
|  | |  | | (_| |         ||     \  /        |
|  |_|  |_|\__, |         ||      \/         |
|           __/ |___  __  ||        ___ ____ |
|          |___/( _ )/  \ ||       |_  )__ / |
|               / _ \ () |||        / / |_ \ |
|               \___/\__/ ||       /___|___/ |
 --------------------------  -----------------

"

LSB=`lsb_release -r | awk {'print $2'}`

echo
echo "Updating APT sources."
echo
apt-get update > /dev/null
echo
echo "Checking for Ansible."
echo
ansible_version=`dpkg -s ansible 2>&1 | grep Version | cut -f2 -d:`
if [[ -z $ansible_version ]]
    then
    echo "Ansible not installed. Installing."
    apt-get -y install python-software-properties
    add-apt-repository -y ppa:rquillo/ansible
    apt-get -y install ansible
    echo
else
    echo "Ansible installed. Proceeding."
    echo
fi

ANS_BIN=`which ansible-playbook`

if [[ -z $ANS_BIN ]]
    then
    echo "Whoops, can't find Ansible anywhere. Aborting run."
    echo
    exit
fi

echo
echo "Validating Ansible hostfile permissions."
echo
chmod 644 /vagrant/provisioning/hosts

# More continuous scroll of the ansible standard output buffer
export PYTHONUNBUFFERED=1

# $ANS_BIN /vagrant/provisioning/playbook.yml -i /vagrant/provisioning/hosts
$ANS_BIN /vagrant/provisioning/playbook.yml -i'127.0.0.1,'

echo
