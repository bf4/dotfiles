#!/usr/bin/env bash

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

fancy_debug() {
  if [ "$VERBOSE" = "true" ]; then
    fancy_echo "$@"
  fi
}

# see http://www.aboutlinux.info/2005/10/10-seconds-guide-to-bash-shell.html
function fn_exists {
  # ! command -v $1 >/dev/null
  which $1 &> /dev/null
  cmd_success
}
# http://stackoverflow.com/questions/5155528/check-if-a-mac-os-x-application-is-present
# http://stackoverflow.com/questions/6682335/how-can-check-if-particular-application-software-is-installed-in-mac-os
function app_exists {
   /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill
   /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister \
   -dump | grep -i $1 &> /dev/null
  cmd_success
}
function cmd_success {
  [[ $? -eq 0 ]]
}
function file_exists {
  [[ -s $1 ]] || [[ -d $1 ]]
}

function not_file_exists {
  [[ ! -s $1 ]] && [[ ! -d $1 ]]
}

function brew_install {
  if brew list $1 &> /dev/null
  then
    fancy_debug "already installed $1"
    last_command_new_install=false
    true
  else
    fancy_debug "installing $@"
    brew install "$@"
    last_command_new_install=$?
  fi
}

# brew_install_or_upgrade() {
#   if brew_is_installed "$1"; then
#     if brew_is_upgradable "$1"; then
#       fancy_echo "Upgrading %s ..." "$1"
#       brew upgrade "$@"
#     else
#       fancy_debug "Already using the latest version of %s. Skipping ..." "$1"
#     fi
#   else
#     fancy_echo "Installing %s ..." "$1"
#     brew install "$@"
#   fi
# }
#
# brew_is_installed() {
#   local name="$(brew_expand_alias "$1")"
#
#   brew list -1 | grep -Fqx "$name"
# }
#
# brew_is_upgradable() {
#   local name="$(brew_expand_alias "$1")"
#
#   ! brew outdated --quiet "$name" >/dev/null
# }
#
#
# brew_expand_alias() {
#   brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
# }

function brew_install_service {
  brew_install $1 && \
    ln -sfv /usr/local/opt/$1/*.plist ~/Library/LaunchAgents && \
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.$1.plist || fancy_echo $!
}

# brew_launchctl_restart() {
#   local name="$(brew_expand_alias "$1")"
#   local domain="homebrew.mxcl.$name"
#   local plist="$domain.plist"
#
#   fancy_debug "Restarting %s ..." "$1"
#   mkdir -p "$HOME/Library/LaunchAgents"
#   ln -sfv "/usr/local/opt/$name/$plist" "$HOME/Library/LaunchAgents"
#
#   if launchctl list | grep -Fq "$domain"; then
#     launchctl unload "$HOME/Library/LaunchAgents/$plist" >/dev/null
#   fi
#   launchctl load "$HOME/Library/LaunchAgents/$plist" >/dev/null
# }

function brew_cask {
  if brew cask list $1 &> /dev/null
  then
    fancy_debug "cask already installed $1"
    last_command_new_install=false
    true
    # use cut to support e.g. google-chrome to match com.google.chrome
  elif app_exists $(echo "$1" | cut -d- -f2)
  then
    fancy_debug "OMG, the app exists for $1"
    last_command_new_install=false
    true
  else
    fancy_echo "installing $@"
    brew cask install "$@"
    last_command_new_install=$?
  fi
}

brew_tap() {
  brew tap "$1" --repair 2> /dev/null
}
# function brew_tap {
#   if brew tap | grep $1 &> /dev/null
#   then
#     fancy_debug "already tapped $1"
#     true
#   else
#     fancy_echo "tapping $@"
#     brew tap "$@"
#   fi
# }

function app_cmd {
  if [ "$platform" = "vagrant" ]
  then
    fancy_echo "running command on vagrant: $@"
    vagrant ssh -c "cd /vagrant && $@"
  else
    fancy_echo "running command locally: $@"
    eval $@
  fi

}
function install_rvm {
  if fn_exists "rvm"
  then
    fancy_debug "we have rvm; you are using $(ruby --version) from $(which ruby)"
  else
    fancy_echo "we don't have rvm installing"
    \curl -sSL https://get.rvm.io | bash -s $@ --auto-dotfiles
  fi
}
function install_ruby {
 if file_exists "$HOME/.rvm/scripts/rvm"
 then
   source "$HOME/.rvm/scripts/rvm"
 else
   source /usr/local/rvm/scripts/rvm
 fi

 rvm use --install $1 --fuzzy --binary

 shift

 if (( $# ))
     then for gem in $@; do
         gem list $gem | grep $gem &> /dev/null || gem install $gem
     done
 fi
}

# gem_install_or_update() {
#   if gem list "$1" --installed > /dev/null; then
#     fancy_debug "Updating %s ..." "$1"
#     gem update "$@"
#   else
#     fancy_echo "Installing %s ..." "$1"
#     gem install "$@"
#     rbenv rehash
#   fi
# }

append_to_rc() {
  local rc="${SHELL}rc"

  local text="$1" $rc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.${rc}.local" ]; then
    rc_path="$HOME/.${rc}.local"
  else
    rc_path="$HOME/.${rc}"
  fi

  if ! grep -Fqs "$text" "$rc_path"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\n" "$text" >> "$rc_path"
    else
      printf "\n%s\n" "$text" >> "$rc_path"
    fi
  fi
}
