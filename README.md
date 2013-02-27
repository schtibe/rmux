rmux
====

Portable configs using rsync. This is a template, but I try to reshape it to a form that allows 
to easily merge changes from upstream. You can add any other config-files or even binaries.
It was originally built for tmux and vim configs and assumes you're using pathogen.

All portable file are stored in ~/.rmux-\<id\>.

Commands:

rmux user@remotehost
	Take local ~/.rmux-\<id\> to remote host and setup vim and tmux

imux user@remotehost
	Install fallback tmux if you cannot install it on the host


Installation
------------

* Check the repository out to ~/.rmux-\<id\>
* Edit README and add your name and email address
* Edit rmuxid and set the id to the previous chosen \<id\>
* Copy or link your ~/.tmux.conf contents to ~/.rmux-\<id\>/tmux.conf
* Copy or link your ~/.bashrc contents to ~/.rmux-\<id\>/bashrc
* Copy or link your ~/.vimrc contents to ~/.rmux-\<id\>/vimrc
* Copy or link your ~/.vim directory to ~/.rmux-\<id\>/vim
  * !! If your replace the ~/.rmux-<id>/vimrc be sure you keep the lines in ~/.rmux-\<id\>/vimrc
* Add the ~/.rmux-\<id\>/bin directory to your $PATH
* Source ~/.rmux-\<id\>/rmuxid in your ~/.bashrc

See ganwells settings as an example:
https://github.com/ganwell/rmux/tree/ganwells_settings

vimrc
-----

See the example vimrc. If you want to link or replace it with your own you need
to add these line:

````vimrc
set nocp
let &rtp .= expand(",$HOME/.rmux-$RMUXID/vim,$HOME/.rmux-$RMUDID/vim/after")
````

vim python path
---------------

An example of adding a python path to bundle libraries:

````vimrc
let $PYTHONPATH .= expand(":$HOME/.rmux-$RMUXID/jedi")
````

Additional content
------------------

* Add a config file ~/.rmux-\<id\>/
* Use the variable $RMUXDIR to find the file on the remote system

Example:

````bash
cp git-prompt.sh ~/.rmux-\<id\>/
````

Add this line to ~/.rmux-\<id\>/bashrc

````bash
source "$RMUXDIR/git-prompt.sh"
````


SSH Settings
------------

You are free to use another ControlPath or even not use ControlMaster. But its
not recommended.

Host *
	Compression yes
	ControlPath ~/.ssh/cm/%r@%h:%p.conn
	ControlPersist yes
	ControlMaster auto
	ServerAliveInterval 600

Create directory ~/.ssh/cm if you use this path
