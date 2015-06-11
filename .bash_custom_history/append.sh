#!/usr/bin/env bash

HISTORY_LOG=${HOME}/.bash_history_all

LC=`echo "$*" | sed -f ~/.bash_custom_history/prep.sed | xargs -I{} echo ${TTY_NAME} '{}'`;
if [[ -z `tail -100 ${HISTORY_LOG} | grep -F "$LC" 2>/dev/null` ]] ; then

    echo "${LC}" >> ${HISTORY_LOG}
fi
