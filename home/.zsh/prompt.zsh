setopt PROMPT_SUBST
# Default Git enabled prompt with dirty state
export PS1="\$(__my_rvm_prompt)\$git_prompt %~
📝 $ "

# Default Git enabled root prompt (for use with "sudo -s")
# doesn't require txtuid
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
