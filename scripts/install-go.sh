#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "You must be root to run this script" 2>&1
    exit 1
fi

# Install go
builddir=$(pwd)
go_version=$(curl -s https://go.dev/dl/?mode=json | jq -r '.[0].version')
rm -rf /usr/local/go
wget https://dl.google.com/go/$go_version.linux-amd64.tar.gz -P $builddir/
tar -xvf $builddir/$go_version.linux-amd64.tar.gz -C /usr/local/
rm $builddir/$go_version.linux-amd64.tar.gz

# Install go packages
# See: https://github.com/golang/vscode-go/wiki/tools
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/josharian/impl@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
