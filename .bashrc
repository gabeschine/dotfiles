[ -n "$PS1" ] && source ~/.bash_profile;

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore out --ignore third_party --ignore flutter -g ""'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
