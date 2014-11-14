#!/usr/bin/env bash

# see http://www.aboutlinux.info/2005/10/10-seconds-guide-to-bash-shell.html
function fn_exists {
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
    echo "already installed $1"
    false
  else
    echo "installing $1"
    brew install $1
  fi
}

function brew_install_service {
  brew_install $1 && \
    ln -sfv /usr/local/opt/$1/*.plist ~/Library/LaunchAgents && \
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.$1.plist || echo $!
}

function brew_cask {
  if brew cask list $1 &> /dev/null
  then
    echo "cask already installed $1"
    false
    # use cut to support e.g. google-chrome to match com.google.chrome
  elif app_exists $(echo "$1" | cut -d- -f2)
  then
    echo "OMG, the app exists for $1"
    false
  else
    echo "installing  $1"
    brew cask install $1
  fi
}

function brew_tap {
  if brew tap | grep $1 &> /dev/null
  then
    echo "already tapped $1"
    false
  else
    echo "tapping  $1"
    brew tap $1
  fi
}

function app_cmd {
  if [ "$platform" = "vagrant" ]
  then
    echo "running command on vagrant: $1"
    vagrant ssh -c "cd /vagrant && $1"
  else
    echo "running command locally: $1"
    eval $1
  fi

}
function install_rvm {
  if fn_exists "rvm"
  then
    echo "we have rvm; you are using $(ruby --version) from $(which ruby)"
  else
    echo "we don't have rvm installing"
    \curl -sSL https://get.rvm.io | bash -s $1 --auto-dotfiles
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
