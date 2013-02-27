#!/usr/bin/env bash

# 5000 unique bash history lines that are shared between 
# sessions on every command. Happy ctrl-r!!
shopt -s histappend
export HISTFILE="$RMUXDIR/bash_history"
export HISTSIZE=10000
export HISTFILESIZE=10000
export PROMPT_COMMAND="history -a; $RMUXDIR/bin/unique_history.py; history -r; $PROMPT_COMMAND"
touch "$RMUXDIR/bash_history"

__git_ps1 ()
{
	local b="$(git symbolic-ref HEAD 2>/dev/null)";
	if [ -n "$b" ]; then
		if [ -n "$s" ]; then
			s=",$s"
		fi
		printf " (%s)" "${b##refs/heads/}";# "$s";
	fi
}

export -f __git_ps1

export VIMINIT="source $RMUXDIR/vimrc"
export LC_ALL="$LC_ALL"
export LANG="$LANG"
export PS1="\[\033[00;32m\]\u\[\033[00;37m\]@\h \[\033[00;34m\]\w [\$(ls -1 | wc -l | sed 's: ::g') files, \$(${gprfx}ls -lah | ${gprfx}grep -m 1 total | ${gprfx}sed 's/total //')] \$(__git_ps1  )\n\[\033[00;33m\]$> \[\033[00m\]"
