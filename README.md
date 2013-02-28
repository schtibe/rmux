rmux
====

Portable configs using rsync. It was originally built for tmux and vim configs and assumes you're using pathogen.
It might still need some refactoring, pull-requests are welcome. Minimal dependencies are:

* ssh
* bash
* rsync

It also assumes that you connect to some kind of unix and has fixes for few quirks on solaris. To make rmux useful you need:

* python (2.6, 2.7. 3.x)
* vim
* tmux

All portable files are stored in ~/.rmux-\<id\>.

Local commands:

rmux user@remotehost \<arguments passed to ssh\>
* Take local ~/.rmux-\<id\> to remote host and setup vim and tmux

imux user@remotehost
* Install fallback tmux if you cannot install it on the host

Remote commands:

tmux
* Create new tmux session

tmuk
* Reattach to session 0

tmuc N
* Reattach to session N

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
* Add the ~/.rmux-\<id\>/bin directory to your $PATH
* Source ~/.rmux-\<id\>/rmuxid in your ~/.bashrc
* Copy or link your ~/.tmux.conf contents to ~/.rmux-\<id\>/tmux.conf
* Copy or link your ~/.bashrc contents to ~/.rmux-\<id\>/bashrc
* Copy or link your ~/.vimrc contents to ~/.rmux-\<id\>/vimrc
* Copy or link your ~/.vim directory to ~/.rmux-\<id\>/vim

Bash History
------------

The template bashrc shares the bash history across bash-sessions and cleans the
history to contain only unique lines. User ctrl-r to access the history.

Remove the section in the bashrc if you don't want this feature.

If you don't share ~/.bashrc you can copy the unique history settings from 
~/.rmux-\<id\>/templates/bashrc to get the feature on your localhost as well.

Default tmux settings
---------------------

The template tmux.conf will map ctrl-b to ctrl-a, according to me ctrl-a is
better. It adds few more shortcuts, please see tmux.conf.

The following line is needed in your tmux.conf:

````
set-option -g default-command "bash --rcfile '$RMUXDIR/init' -i"
````

I also recommend this because of vim acting strange without:

````
set -g default-terminal "screen-256color"
````

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

An example of adding a python path to bundle libraries in rmux:

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
highly recommended to use the setting below (ControlPersist is essential for the 
performance of rmux).

````
Host *
	Compression yes
	ControlPath ~/.ssh/cm/%r@%h:%p.conn
	ControlPersist yes
	ControlMaster auto
	ServerAliveInterval 600
````

Create directory ~/.ssh/cm if you use this path

These settings will keep a master connection to the server open. You can close it
(I never do):

````
ssh user@host -O exit
````

But when your notebook was sleeping and the TCP conenctions died it will take some time to recover.
I usually don't want to wait and simply do:

````
killall ssh
````

Since your notebook just woke up, you shouldn't kill anything alive.

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
lrwxr-xr-x  1 ganwell  staff    25B Feb 27 21:44 tmux.conf -> /Users/ganwell/.tmux.conf
-rwxr-xr-x  1 ganwell  staff   542B Feb 27 21:23 tmux-start
lrwxr-xr-x  1 ganwell  staff    19B Feb 27 21:44 vim -> /Users/ganwell/.vim
lrwxr-xr-x  1 ganwell  staff    21B Feb 27 21:44 vimrc -> /Users/ganwell/.vimrc
````
