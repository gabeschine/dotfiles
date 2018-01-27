if [[ `tty` != "not a tty" ]] ; then # interactive shell

  ##################################
  # BEG History manipulation section
  export TTY_NAME=`tty|sed -e 's|/dev/||' -e 's|/|_|'`
  export HISTFILESIZE=2000
  export HISTSIZE=2000
  export HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S] "

  history -r

  if [ -n "$PROMPT_COMMAND" ]; then
      #It is annoying that in PROMPT_COMMAND $HISTCMD is always 1 hence the external script
      CLEANED_PROMPT_COMMAND=$(echo "$PROMPT_COMMAND" | sed 's/;[[:space:]]*$//')
      export PROMPT_COMMAND="$CLEANED_PROMPT_COMMAND; ${HOME}/.bash_custom_history/append.sh \`history 1\`"
  else
      export PROMPT_COMMAND="${HOME}/.bash_custom_history/append.sh \`history 1\`"
  fi

  function save_last_command {
      # Only want to do this once per process
      if [ -z "$SAVE_LAST" ]; then
          export SAVE_LAST="done"
          ${HOME}/.bash_custom_history/append.sh "`history 1`"
      fi
  }
  trap 'save_last_command' EXIT

  # In case we have bash-precmd installed and it's taking over $PROMPT_COMMAND.
  function custom_history_append() {
      ${HOME}/.bash_custom_history/append.sh `history 1`
  }
  precmd_functions+=(custom_history_append)
  # END History manipulation section
  #################################
fi

function hs {
  grep "$*" ~/.bash_history_all | tail -50
}

function hsa {
  grep "$*" ~/.bash_history_all
}

function history_search_percol {
  #NEW_INPUT=$(sort -k 4 ~/.bash_history_all | grep -v "end session thatguy" | uniq -f 4 | sort -k 2,3 | cut -d " " -f 4- | percol --reverse --query="$READLINE_LINE" --caret-position="$READLINE_POINT" --prompt-bottom --result-bottom-up)
  NEW_INPUT=$(cat ~/.bash_history_all | grep -v "end session thatguy" | cut -d " " -f 4- | percol --reverse --query="$READLINE_LINE" --caret-position="$READLINE_POINT" --prompt-bottom --result-bottom-up)
  READLINE_LINE=$NEW_INPUT
  READLINE_POINT=$(echo "$NEW_INPUT" | wc -c)
}
#bind -x '"\C-r":history_search_percol'
