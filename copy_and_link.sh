#!/usr/bin/env sh
if [ ! -n "$1" ]
then
    echo "Usage: ./copy_and_link.sh .ackrc"
    exit 1
fi
pwd="$(pwd)"
home="$HOME"
echo "pwd is $pwd; home is $home"

for file; do

    home_file="$home/$file"
    pwd_file="$pwd/$file"
    if test -s $home_file
    then
        echo "Copying and linking $file"
        cp -Rp "$home_file" . && rm -rf "$home_file" && ln -s "$pwd_file" "$home_file"
    elif test -s "$pwd_file"
    then
        echo "Linking $file"
        ln -s "$pwd_file" "$home_file"
    else
        echo "Could not find $file in $homeor $pwd"
    fi
done 
