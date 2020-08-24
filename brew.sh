#!/usr/bin/env bash

# Install command-line tools using Homebrew.

. "$HOME/${DOTFILES_HOME}/../functions.bash"
. "$HOME/${DOTFILES_HOME}/.shells/colors.sh"
[ -f "$HOME/.brew_local.sh" ] && . "$HOME/.brew_local.sh"

# Make sure we’re using the latest Homebrew.
brewup

# Upgrade any already-installed formulae.
brew upgrade --all

# TODO: consider https://github.com/Homebrew/homebrew-bundle
# with a Brewfile and/or Caskfile
# cask() {
#   brew cask install $@
#   brew cask list | sed 's/^/cask install /' > "${HOME}/Caskfile"
# }

# Heroku Toolbelt for interacting with the Heroku API
# brew_install_or_upgrade 'heroku-toolbelt'

# skip with parity
# RCM for managing company and personal dotfiles
# if ! command -v rcup >/dev/null; then
#   brew_tap 'thoughtbot/formulae'
#   brew_install_or_upgrade 'rcm'
# fi
#
# if [ -f "$HOME/.laptop.local" ]; then
#   . "$HOME/.laptop.local"

# brew_tap 'caskroom/cask'
# brew_install_or_upgrade 'brew-cask'
#
# brew cask install dropbox
# brew cask install google-chrome
# brew cask install rdio
#
# gem_install_or_update 'parity'
#
# brew_install_or_upgrade 'tree'
# brew_install_or_upgrade 'watch'

# Follow shell style guidelines by using ShellCheck and Syntastic.
# http://www.shellcheck.net/about.html
# https://github.com/scrooloose/syntastic
brew_install shellcheck
# fi
# see https://github.com/thoughtbot/laptop/pull/372 re: gnupgp
#  brew_install_or_upgrade 'gpg2'
# see https://github.com/thoughtbot/laptop/pull/391
#  brew_install_or_upgrade 'rbenv-gem-rehash'


# hub for interacting with the GitHub API
# brew_install_or_upgrade 'hub'
# already_installed=$(fn_exists hub)
# brew_install "hub"
# if [[ $already_installed -eq 0 ]] && [[ $last_command_new_install ]]; then
#   echo "already_installed '${already_installed}'"
#   fancy_echo "See https://github.com/github/hub for what hub adds to git"
# fi

# get the nice vim that macvim comes with
# brew_install_or_upgrade 'vim'
brew_install macvim | grep -q XCode && fancy_echo "Installing macvim may have failed because you haven't installed the full XCode.\n$!"

# Exuberant Ctags for indexing files for vim tab completion
# brew_install_or_upgrade 'ctags'
brew_install ctags
# Tmux for saving project state and switching between projects
# brew_install_or_upgrade 'tmux'
brew_install tmux

already_installed=$(fn_exists tmux)
brew_install reattach-to-user-namespace --wrap-pbcopy-and-pbpaste --wrap-launchtl
# brew_install_or_upgrade 'reattach-to-user-namespace'
if [[ $already_installed -eq 0 ]] && [[ $last_command_new_install ]]; then
  echo "already_installed '${already_installed}'"
  fancy_echo "Run tmux kill-server"
fi
brew_install "tree"
brew_install "trash"

brew_install bash-completion
# cabextract
# cmake

# elasticsearch
# echo -e "$txtgrn"
# echo -e 'elastic search needs java'
# echo -e "$txtrst"
# brew_cask java
# echo -e "$txtred"
# echo -e 'If elasticsearch service fails to start, and you are in tmux/screen, try in a new tab:'
# echo -e 'launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist'
# echo -e "$txtrst"
# brew_cask java
# brew_install_service elasticsearch

# erlang
# exercism
# ghi
# graphviz
brew_install grc
# ImageMagick for cropping and resizing images
# brew_install_or_upgrade 'imagemagick'
# imagemagick
# libevent
# libgit2
# maven
# Node.js and NPM, for running apps and installing JavaScript packages
# brew_install_or_upgrade 'node'
# node
# openssl
# ossp-uuid
# pcre
# pkg-config

# Postgresql for storing relational data
# brew_install_or_upgrade 'postgres'
# brew_launchctl_restart 'postgresql'
# which pg_ctl &> /dev/null
# if [ $? -ne 0 ] ; then
#   if brew cask list &> /dev/null ; then
#     if brew cask list postgres &> /dev/null; then
#       echo -e "$txtgrn"
#       echo -e "postgres.app cask installed"
#       echo -e "$txtrst"
#     else
#       echo -e "$txtgrn"
#       echo -e "add postgres.app to your path per http://postgresapp.com/documentation/cli-tools.html"
#       echo -e "$txtrst"
#       export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
#       brew cask install postgresql --appdir=/Applications
#     fi
#   else
#     brew_install_service postgresql || exit 1
#   fi
#   ARCHFLAGS="-arch x86_64" gem install pg
# fi

# readline

# Redis for storing key-value data
# brew_install_or_upgrade 'redis'
# brew_launchctl_restart 'redis'
# echo "Checking for redis-cli..."
# if which redis-cli &> /dev/null; then
#   if redis-cli ping &> /dev/null; then
#     echo -e "$txtgrn"
#     echo -e "redis is running"
#     echo -e "$txtrst"
#   else
#     echo -e "$txtred"
#     echo -e "Redis was not running."
#     echo -e "You should start it via your daemon system or in another terminal."
#     echo -e "If you're using homebrew, run 'brew uninstall redis; bin/boostrap'"
#     echo -e "I'm going to try to start it for you"
#     echo -e "$txtrst"
#     /usr/local/opt/redis/bin/redis-server /usr/local/etc/redis.conf || exit 1
#   fi
# else
#   echo -e "$txtgrn"
#   echo -e "Installing redis via brew..."
#   echo -e "$txtrst"
#   brew_install_service redis
# fi

# scala
brew_install terminal-notifier
# The Silver Searcher for finding things in files
# brew_install_or_upgrade 'the_silver_searcher'
# the_silver_searcher
# wget
# wine
# winetricks
# youtube-dl

# ack
# apple-gcc42
# bazaar
# beanstalk
# cabal-install
# chruby
# cscope
# curl
# curl-ca-bundle
# cvs
# d-bus
# doxygen
# dvdbackup
# elinks
# emacs
# faac
# ffmpeg
# flasm
# flex
# fortune
# freetype
# fswatch
# gcc
# gdbm
# gdk-pixbuf
# geoip
# gettext
# ghc
# git
# glew
# glib
# gnupg
# gnutls
brew_install go
# gobject-introspection
# gource
# gtk+
# harfbuzz
# htmldoc
# htop-osx
# icu4c
# intltool
# irssi
# jp2a
# jpeg
# lame
# leiningen
# libevent
# libffi
# lynx
# x11/meld
# nettle
# nginx
# nvm
# openjpeg
# phantomjs
# poppler
# ppl011
# pv
# python
# python3
brew_install pyenv # PythonBrew replacement
# Qt for headless JavaScript testing via Capybara Webkit
# brew_install_or_upgrade 'qt'
# qt
# Rbenv for managing versions of Ruby
# rbenv
# rtmpdump
# Ruby Build for installing Rubies
# ruby-build
# source-highlight
# sqlite
# texi2html
# brew_install the_platinum_searcher # aka 'pt'
# tmate
# tor
# unixodbc
# wemux
# wxmac
# x264
# xvid
# xz
# yasm

## Homebrew Cask (for binaries)

# already_installed=$(app_exists Alfred)
# brew_cask "alfred" --appdir="/Applications"
# if [[ $already_installed -eq 0 ]] && [[ $last_command_new_install ]]; then
#   echo "already_installed '${already_installed}'"
#   fancy_echo "open alfred from '/opt/hombrew-cask/Caskroom'"
# fi

brew_cask "caffeine" --appdir="/Applications" # TODO: add to login items
brew_cask "cd-to" --appdir="/Applications"
# TODO: add instructions for dragging link to finder
brew_cask "nvalt" --appdir="/Applications"
# brew_cask "adium"" --appdir="/Applications"
# brew_cask "atom" --appdir="/Applications"
# brew_cask "audacity" --appdir="/Applications"
# brew_cask "boot2docker" --appdir="/Applications"
# brew_cask "calibre" --appdir="/Applications"
# brew_cask "cyberduck" --appdir="/Applications"
# brew_cask "fluid" --appdir="/Applications"
brew_cask "firefox" --appdir="/Applications"
brew_cask "github" --appdir="/Applications"
brew_cask "google-chrome" --appdir="/Applications"
brew_cask "google-drive" --appdir="/Applications"
# brew_cask "hipchat" --appdir="/Applications"
# brew_cask "istat-menus" --appdir="/Applications"
brew_cask "iterm2" --appdir="/Applications"
# brew_cask "java" --appdir="/Applications"
brew_cask "keka" --appdir="/Applications"
# brew_cask "launchrocket" --appdir="/Applications"
# brew_cask lunchy # lunchy-go
# brew_cask "libreoffice" --appdir="/Applications"
# brew_cask "minecraft" --appdir="/Applications"
# brew_cask "netnewswire" --appdir="/Applications"
# brew_cask "onyx" --appdir="/Applications"
# brew_cask "osxfuse" --appdir="/Applications"
# brew_cask "pgadmin3" --appdir="/Applications"
# brew_cask "picasa" --appdir="/Applications"
# brew_cask "postgres" --appdir="/Applications"
# brew_cask "quiterss" --appdir="/Applications"
# brew_cask "racket" --appdir="/Applications"
brew_cask "slack" --appdir="/Applications"
# brew_cask sequel-pro --appdir="/Applications"
# brew_cask "sqlitebrowser" --appdir="/Applications"
# brew_cask "sublime-text" --appdir="/Applications"
# brew_cask "tcpblock" --appdir="/Applications"
# brew_cask "tunnelblick" --appdir="/Applications"
brew_cask "vagrant" --appdir="/Applications"
# brew_cask "virtualbox" --appdir="/Applications" # doesn't install through script
brew_cask "vlc" --appdir="/Applications"
# brew_cask "vmware-fusion" --appdir="/Applications"
# brew_cask "wireshark" --appdir="/Applications"
# brew_cask "xquartz" --appdir="/Applications" # doesn't install through script

# Remove outdated versions from the cellar.
brew cleanup
