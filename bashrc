#!/usr/bin/env bash

# 5000 unique bash history lines that are shared between 
# sessions on every command. Happy ctrl-r!!
shopt -s histappend
touch "$RMUXDIR/bash_history"
export HISTFILE="$RMUXDIR/bash_history"
export HISTSIZE=10000
export HISTFILESIZE=10000
if [ "$PROMPT_COMMAND" == "" ]; then
	export PROMPT_COMMAND="history -a; $RMUXDIR/bin/unique_history.py; history -r"
else
	export PROMPT_COMMAND="history -a; $RMUXDIR/bin/unique_history.py; history -r; $PROMPT_COMMAND"
fi
gprfx=""
if [ -e /opt/csw/bin/gls ]; then
	gprfx="g"
fi
if [ -e /usr/bin/gls ]; then
	gprfx="g"
fi

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

export PS1="\[\033[00;32m\]\u\[\033[00;37m\]@\h \[\033[00;34m\]\w [\$(ls -1 | wc -l | sed 's: ::g') files, \$(${gprfx}ls -lah | ${gprfx}grep -m 1 total | ${gprfx}sed 's/total //')] \$(__git_ps1  )\n\[\033[00;33m\]$> \[\033[00m\]"
