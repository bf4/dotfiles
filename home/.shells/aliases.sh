#!/usr/bin/env sh
alias ber='bundle exec rake'
alias bes='bundle exec rspec -fs'
alias bec='bundle exec cucumber -r features'
alias bsc='bundle exec rails s'
alias bounce='touch tmp/restart.txt'
alias be='bundle exec'

# alias tmux="TERM=screen-256color-bce tmux"
alias pg="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log"
#
# use macvim binary if present (it has ruby compiled)
# alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
# [[ -s "/Applications/MacVim.app/Contents/MacOS/Vim" ]] && alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
