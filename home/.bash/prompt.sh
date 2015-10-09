# http://www.thegeekstuff.com/2008/09/bash-shell-take-control-of-ps1-ps2-ps3-ps4-and-prompt_command/
# Default Git enabled prompt with dirty state
export PS1="\$(__my_rvm_prompt)\$git_prompt \w\n📝 $ "

# Default Git enabled root prompt (for use with "sudo -s")
# doesn't require txtuid
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
