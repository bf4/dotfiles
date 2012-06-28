# export PATH=/usr/local/bin:$HOME/bin:$PATH
export PATH=$PATH:/usr/local/bin:$HOME/bin
# /usr/bin:/usr/local/sbin:
export PATH=$PATH:$HOME/.cabal/bin

source ~/.git-completion.sh
#set rvm_trust_rvmrcs_flag=1
# export NODE_PATH="/usr/local/lib/node"
export NODE_PATH="/usr/local/lib/node_modules"
# export PATH=$PATH:/usr/local/share/npm/bin
#alias ls='ls --color=auto'
#PS1="\e[32;40m\u@\w\[\e[0m\]\n[\h \W$(__git_ps1 " (%s)")]\$> "
# alias mmx='cd ~/workspace'
PS1='[\W$(__git_ps1 " (%s)")]\$ '
PS1="\$(~/.rvm/bin/rvm-prompt) $PS1"
#source "$rvm_path/contrib/ps1_functions"
#ps1_set
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
export rvm_pretty_print_flag=1
alias gitdiffgraph="git log --pretty=format:'%h %s' --graph"
# alias models2svg="~/bin/models2svg"
# alias controllers2svg="~/bin/controllers2svg"
fortune
# use macvim binary if present (it has ruby compiled)
# alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
# [[ -s "/Applications/MacVim.app/Contents/MacOS/Vim" ]] && . alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias tmux="TERM=screen-256color-bce tmux"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
