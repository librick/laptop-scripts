flatpaks=$(flatpak list --user --app --columns=application |\
    sed "s/Application ID//")
echo $flatpaks | tr " " "\n"
