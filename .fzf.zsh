# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null
[[ $- == *i* ]] && source "/usr/share/doc/fzf/examples/key-bindings.zsh" 2> /dev/null

# Key bindings
# ------------
# source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" 2> /dev/null
# source "/usr/share/doc/fzf/examples/key-bindings.zsh" 2> /dev/null
