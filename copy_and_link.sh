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
        echo "$home_file already exists"
    elif test -s "$pwd_file"
    then
        echo "Linking $file"
        ln -s "$pwd_file" "$home_file"
    else
        echo "Could not find $file in $home or $pwd"
    fi
done 
