favs=$(gsettings get org.gnome.shell favorite-apps)
echo $favs | tr "," "\n" | tr -d "[]' "
