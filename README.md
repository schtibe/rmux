rmux
====

Commands:

rmux user@remotehost
	Take local .rmux-id to remote host and setup vim and tmux

imux user@remotehost
	Install fallback tmux if you cannot install it on the host


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
