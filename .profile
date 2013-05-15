source /usr/local/opt/chruby/share/chruby/chruby.sh
export RUBIES=(
  $HOME/.rubies/*
  $HOME/.rvm/rubies/*
)
# autoswitching on .ruby-version
source /usr/local/opt/chruby/share/chruby/auto.sh

