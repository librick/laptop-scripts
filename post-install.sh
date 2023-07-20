#!/bin/bash
if [[ $EUID -ne 1000 ]]; then
    echo "You must have EUID=1000 to run this script" 2>&1
    exit 1
fi

builddir=$(pwd)
plaintext_dir=$builddir/age-plaintext

# Enable GNOME extensions
gnome-extensions enable -q blur-my-shell@aunetx
gnome-extensions enable -q dash-to-dock@micxgx.gmail.com
gnome-extensions enable -q caffeine@patapon.info
gnome-extensions enable -q PrivacyMenu@stuarthayhurst

# Install vscodium extensions
vscodium_exts_file=$plaintext_dir/vscodium-extensions.txt
readarray -t vscodium_exts < <(cat $vscodium_exts_file)
for ext in "${vscodium_exts[@]}"; do
    codium --install-extension $ext --force
done
