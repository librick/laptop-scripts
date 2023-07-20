#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

username=$(id -u -n 1000)
export CARGO_HOME="/home/$username/.local/share/cargo"
export RUSTUP_HOME="/home/$username/.local/share/rustup"
echo CARGO_HOME is $CARGO_HOME
echo RUSTUP_HOME is $RUSTUP_HOME
curl https://sh.rustup.rs --proto '=https' --tlsv1.2 -sSf | sh -s -- -y
source /home/$username/.local/share/cargo/env

# Install cargo packages
cargo install lsd
