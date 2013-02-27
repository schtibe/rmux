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

Think of an unique id for yourself, a nick name or something. It should
NOT conflict with other users on the target systems. We call id \<id\>.


````bash
cd
git clone git@github.com:ganwell/rmux.git ~/.rmux-<id>
cd ~/.rmux-<id>
./init-templates.sh
````

* Edit README and add your name and email address
* Edit rmuxid and set the id to the previous chosen \<id\>
* Copy or link your ~/.tmux.conf contents to ~/.rmux-\<id\>/tmux.conf
* Copy or link your ~/.bashrc contents to ~/.rmux-\<id\>/bashrc
* Copy or link your ~/.vimrc contents to ~/.rmux-\<id\>/vimrc
* Copy or link your ~/.vim directory to ~/.rmux-\<id\>/vim
* Add the ~/.rmux-\<id\>/bin directory to your $PATH
* Source ~/.rmux-\<id\>/rmuxid in your ~/.bashrc

History
-------

The template bashrc shares the bash history across sessions and cleans the
history to contain only unique lines. Remove the section in the bashrc if you
don't want this feature.

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

You are free to use another ControlPath or even not use ControlMaster. But it is
highly recommended to use the setting below.

Host *
	Compression yes
	ControlPath ~/.ssh/cm/%r@%h:%p.conn
	ControlPersist yes
	ControlMaster auto
	ServerAliveInterval 600

Create directory ~/.ssh/cm if you use this path

Example for rmux-\<id\> directory
---------------------------------

````bash
$> ls -lh
total 3192
-rw-r--r--  1 ganwell  staff    44B Feb 27 21:23 README
-rw-r--r--  1 ganwell  staff   2.4K Feb 27 21:40 README.md
-rw-------  1 ganwell  staff   984B Feb 27 21:44 bash_history
-rwxr-xr-x  1 ganwell  staff   1.2K Feb 27 21:24 bashrc
drwxr-xr-x  5 ganwell  staff   170B Feb 27 21:40 bin
-rwxr-xr-x  1 ganwell  staff   978B Feb 27 21:23 init
-rwxr-xr-x  1 ganwell  staff    41B Feb 27 21:23 init-templates.sh
-rw-r--r--  1 ganwell  staff   984B Feb 27 21:44 my_history
-rwxr-xr-x  1 ganwell  staff    79B Feb 27 21:29 rmuxid
drwxr-xr-x  7 ganwell  staff   238B Feb 27 21:35 templates
-rwxr-xr-x  1 ganwell  staff   1.5M Feb 27 21:23 tmux-bin
lrwxr-xr-x  1 ganwell  staff    25B Feb 27 21:44 tmux-conf -> /Users/ganwell/.tmux.conf
-rwxr-xr-x  1 ganwell  staff   542B Feb 27 21:23 tmux-start
lrwxr-xr-x  1 ganwell  staff    19B Feb 27 21:44 vim -> /Users/ganwell/.vim
lrwxr-xr-x  1 ganwell  staff    21B Feb 27 21:44 vimrc -> /Users/ganwell/.vimrc
````
