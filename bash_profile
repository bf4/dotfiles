export PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:$HOME/bin:/usr/local/zend/mysql/bin:$PATH
source /Users/benjo/.pythonbrew/etc/bashrc
source "`brew --prefix grc`/etc/grc.bashrc"
source ~/.git-completion.sh
#set rvm_trust_rvmrcs_flag=1
export MMX_MYSQL_GEM_VERSION=2.7
export NODE_PATH="/usr/local/lib/node"
export PATH=$PATH:/usr/local/share/npm/bin
#alias ls='ls --color=auto'
#PS1="\e[32;40m\u@\w\[\e[0m\]\n[\h \W$(__git_ps1 " (%s)")]\$> "
alias mmx='cd ~/workspace'
PS1='[\W$(__git_ps1 " (%s)")]\$ '
PS1="\$(~/.rvm/bin/rvm-prompt) $PS1"
#source "$rvm_path/contrib/ps1_functions"
#ps1_set
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
export rvm_pretty_print_flag=1
alias gitdiffgraph="git log --pretty=format:'%h %s' --graph"
alias models2svg="~/bin/models2svg"
alias controllers2svg="~/bin/controllers2svg"
fortune
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
