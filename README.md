rmux
====

Commands:

rmux user@remotehost
	Take local .rmux-id to remote host and setup vim and tmux

imux user@remotehost
	Install fallback tmux if you cannot install it on the host


Installation
------------

* Check the repository out to ~/.rmux-<id>
* Edit README and add your name and email address
* Edit rmuxid and set the id to the previous chosen <id>
* Copy or link your ~/.vim directory contents to ~/.rmux-<id>/vim
* Copy or link your ~/.vimrc contents to ~/.rmux-<id>/vimrc
  * !! If your replace the ~/.rmux-<id>/vimrc be sure you keep the lines in ~/.rmux-<id>/vimrc
* Add the ~/.rmux-<id>/bin directory to your $PATH
* Source ~/.rmux-<id>/rmuxid in your ~/.bashrc

See ganwells settings as an example:
https://github.com/ganwell/rmux/tree/ganwells_settings

Additional content
------------------

* Add a config file ~/.rmux-<id>/
* Use the variable $RMUXDIR to find the file on the remote system

Example:

````bash
cp git-prompt.sh ~/.rmux-<id>/
````

Add this line to ~/.rmux-<id>/bashrc

````bash
source "$RMUXDIR/git-prompt.sh
````


SSH Settings
------------

It recommended to user ControlMaster

Host *
	Compression yes
	ControlPath ~/.ssh/cm/%r@%h:%p.conn
	ControlPersist yes
	ControlMaster auto
	ServerAliveInterval 600

Create directory ~/.ssh/cm if you use that path
