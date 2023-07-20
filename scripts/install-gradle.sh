#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "You must be root to run this script" 2>&1
    exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)
DEBIAN_FRONTEND=noninteractive

# Install gradle
apt-get install -y openjdk-17-jdk
gradle_version=$(python3 $builddir/scripts/github-tag.py gradle/gradle)
gradle_version_no_v=$(echo $gradle_version | sed "s/^v//")
gradle_url=https://services.gradle.org/distributions/gradle-$gradle_version_no_v-bin.zip

rm -rf /home/$username/foss/gradle
rm -rf /tmp/gradle-*
temp_dir=/tmp/gradle-$(openssl rand -hex 8)
mkdir -p $temp_dir
wget $gradle_url -O $temp_dir/gradle.zip
cd $temp_dir
unzip gradle.zip
mv $temp_dir/gradle-$gradle_version_no_v /home/$username/foss/gradle
rm -rf $temp_dir

chown -R $username:$username /home/$username/foss/gradle
ln -s -f /home/$username/foss/gradle/bin/gradle /home/$username/.local/bin
chown $username:$username /home/$username/.local/bin/gradle
