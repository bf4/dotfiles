#!/usr/bin/env bash
function find_apps {
  find \
    "$HOME/Applications" \
    "/Applications" \
    "/Library/Developer" \
    "/Developer/Applications" \
    \( -name "*.app" -type d \) 2>/dev/null
}
function find_plists {
  find \
    "$HOME/Library/LaunchAgents" \
    "$HOME/Library/Application Support" \
    "/Library/LaunchAgents" \
    "/Library/LaunchDaemons" \
    "/Library/StartupItems" \
    "/Library/Internet Plug-Ins" \
    "/Library/Application Support" \
    \( -name "*.plist" -type f \) 2>/dev/null
}

function find_all {
  find_apps
  find_plists
}
case "$1" in

  all)
    find_all
  ;;

  plists)
    find_plists
  ;;

  apps)
    find_apps
  ;;

  *)
    echo "Usage: ./my_apps.sh [all|plists|apps]"
  ;;
esac
