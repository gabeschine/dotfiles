if [[ `tty` != "not a tty" ]] ; then # interactive shell

  ##################################
  # BEG History manipulation section
  export TTY_NAME=`tty|sed -e 's|/dev/||' -e 's|/|_|'`
  export HISTFILESIZE=2000
  export HISTSIZE=2000
  export HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S] "
  export HISTFILE=$HOME/.bash_history.${TTY_NAME}
  rm -f $HISTFILE

  # This command is incredibly slow.
#  tail --lines=$(( $HISTFILESIZE + 200 )) ${HOME}/.bash_history_all | sort -u -m -k 4  | tail --lines=$HISTFILESIZE |awk -f ~/.bash.history_parse.awk >> $HISTFILE

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
          echo "${TTY_NAME} [`date +'%m-%d-%Y_%T'`] # end session $USER@${HOSTNAME}:`tty`" >> ${HOME}/.bash_history_all
          rm -f $HISTFILE
      fi
  }
  trap 'save_last_command' EXIT

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
  NEW_INPUT=$(sort -r -k 4 ~/.bash_history_all | grep -v "end session thatguy" | uniq -f 4 | sort -k 2,3 | cut -d " " -f 4- | percol --reverse --query="$READLINE_LINE" --caret-position="$READLINE_POINT" --prompt-bottom --result-bottom-up)
  READLINE_LINE=$NEW_INPUT
  READLINE_POINT=$(echo "$NEW_INPUT" | wc -c)
}
bind -x '"\C-r":history_search_percol'
