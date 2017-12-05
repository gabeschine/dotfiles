# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/google/home/thatguy/.fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/google/home/thatguy/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/google/home/thatguy/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/google/home/thatguy/.fzf/shell/key-bindings.bash"
