export PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:$HOME/bin:$PATH
source ~/.git-completion.sh
#set rvm_trust_rvmrcs_flag=1
export MMX_MYSQL_GEM_VERSION=2.7
export NODE_PATH="/usr/local/lib/node"
export PATH=$PATH:/usr/local/share/npm/bin
#alias ls='ls --color=auto'
#PS1="\e[32;40m\u@\w\[\e[0m\]\n[\h \W$(__git_ps1 " (%s)")]\$> "
PS1='[\W$(__git_ps1 " (%s)")]\$ '
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
alias mmx='cd ~/workspace'
alias gitdiffgraph="git log --pretty=format:'%h %s' --graph"
alias models2svg="~/bin/models2svg"
alias controllers2svg="~/bin/controllers2svg"
fortune
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
