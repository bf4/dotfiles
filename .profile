# source /usr/local/opt/chruby/share/chruby/chruby.sh
# export RUBIES=(
#   $HOME/.rubies/*
#   $HOME/.rvm/rubies/*
# )
# autoswitching on .ruby-version
# source /usr/local/opt/chruby/share/chruby/auto.sh
export PATH="$HOME/.pollev/bin:$PATH"
alias pg="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log"
alias git="hub"
# rbenv init
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
