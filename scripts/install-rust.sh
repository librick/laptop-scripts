#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
echo CARGO_HOME is $CARGO_HOME
echo RUSTUP_HOME is $RUSTUP_HOME
curl https://sh.rustup.rs --proto '=https' --tlsv1.2 -sSf | sh -s -- -y

# Install cargo packages
cargo install lsd
