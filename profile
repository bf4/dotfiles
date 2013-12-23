PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE}; "
export NODE_PATH=/usr/local/lib/node_modules
[[ -s '/usr/local/bin/hub' ]] && alias git=hub
# do not check GHI_TOKEN into source control
export GHI_TOKEN="wouldntyouliketoknow"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
