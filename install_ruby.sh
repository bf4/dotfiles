#!/usr/bin/env bash
# https://gistlog.co/daqo/db4de42c9dea0a7d2a03

set -e

# brew update
# brew install ruby-install -HEAD # ruby-install is needed to facilitate installing additional version of Rubies.
#
# # check installed
# ruby-install -V # ruby-install: 0.5.1
#
# # see versions
# ruby-install
#
# # install into ~/.rubies  (or /opt/rubies if root)
# ruby-install ruby 2.2.2
#
# brew install chruby

# add to bashrc or zshrc
# source /usr/local/opt/chruby/share/chruby/chruby.sh
#
# # chruby ruby-2.2.2
# ruby -v
#
# # auto-switching
# # add to bashrc or zshrc
# source /usr/local/share/chruby/auto.sh

# in env
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby 2.2.2
