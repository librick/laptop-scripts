#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "You must be root to run this script" 2>&1
    exit 1
fi

DEBIAN_FRONTEND=noninteractive
username=$(id -u -n 1000)
apt-get install -y debconf debconf-utils
echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections
apt-get install -y wireshark
usermod -aG netdev $username
