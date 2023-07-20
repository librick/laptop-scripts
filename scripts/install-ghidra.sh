#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

# Install dependencies
sudo apt-get install -y make gcc g++

# Build ghidra
ghidra_install_path=$HOME/foss/ghidra
rm -rf $ghidra_install_path
git clone --depth 1 https://github.com/NationalSecurityAgency/ghidra.git $ghidra_install_path
cd $ghidra_install_path
gradle -I gradle/support/fetchDependencies.gradle init
gradle buildGhidra

cd $ghidra_install_path/build/dist
unzip ghidra*.zip
ghidra_bin_dir=$(find $ghidra_install_path/build/dist/ -mindepth 1 -maxdepth 1 -type d)
ln -s -f $ghidra_bin_dir/ghidraRun $HOME/.local/bin/ghidra
