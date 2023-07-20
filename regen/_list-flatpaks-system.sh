flatpaks=$(flatpak list --system --app --columns=application |\
    sed "s/Application ID//")
echo $flatpaks | tr " " "\n"
