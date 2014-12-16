#!/bin/bash
echo "

  ooooo   ooooo   .oooooo.    oooooo     oooo
  \`888'   \`888'  d8P'  \`Y8b    \`888.     .8'
   888     888  888             \`888.   .8'
   888ooooo888  888              \`888. .8'
   888     888  888     ooooo     \`888.8'
   888     888  \`88.    .88'       \`888'
  o888o   o888o  \`Y8bood8P'         \`8'

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

# $ANS_BIN /vagrant/provisioning/playbook.yml -i /vagrant/provisioning/hosts
$ANS_BIN /vagrant/provisioning/playbook.yml -i'127.0.0.1,'

echo
