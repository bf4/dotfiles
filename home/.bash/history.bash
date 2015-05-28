#!/usr/bin/env sh

# see
# http://stackoverflow.com/questions/338285/prevent-duplicates-from-being-saved-in-bash-history#answer-7449399
# http://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
# avoid duplicates..
# https://github.com/companygardener/dotfiles/blob/b76d3a83f46b3d70e7d75573e2fc5728730f9c38/home/bashrc
export HISTFILESIZE=300000
export HISTIGNORE="&:ls:[bf]g:exit:history"
# export HISTCONTROL=ignoreboth
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
# append history entries..
shopt -s histappend
shopt -s checkwinsize

# After each command, save and reload history
# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a;
# history -c; history -r"
