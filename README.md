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
* Edit rmuxid and set the id to the previous chosen <id>
* Copy or link your ~/.vim directory contents to ~/.rmux-<id>/vim
* Add the ~/.rmux-<id>/bin directory to your $PATH
* Source ~/.rmux-<id>/rmuxid in your ~/.bashrc
* Copy or link ~/.bash_history to ~/.rmux-<id>/bash_history


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
