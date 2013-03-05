# rmux #

Portable configs using rsync. It was originally built for tmux and vim configs, but it will work with anything that
takes config-location as argument or from a environment variable.

Minimal dependencies are:

* ssh
* bash
* rsync

It assumes that you connect to some kind of unix. The default templates are built for:

* vim
* tmux

For the bash history feature you need:

* python (2.6, 2.7. 3.x)

All portable files are stored in ~/.rmux-\<id\>.

### Commands ###

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

rxsu
* Get root privileges without losing your settings

## Installation ##

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

Optional:

* Create ~/.rmux-\<id\>/bashpre if you need to execute something
  the bash is set up. It will be source in init.

### SSH settings ###

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

## Default tmux settings ##

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

### tmux hooks ###

You can place ~/.rmux-\<id\>/tmux-attach-hook and
~/.rmux-\<id\>/tmux-detach-hook on a remote system to do something on
detach/attach. These files won't be synced, you have to place them directly on
the remote system.

## Vim ##

### vimrc ###

See the example vimrc. If you want to link or replace it with your own you need
to add these lines:

````vimrc
set nocp
let &rtp .= expand(",$RMUXDIR/vim,$RMUXDIR/vim/after")
````

### Vim python path ###

An example of adding a python path to bundle libraries in rmux:

````vimrc
let $PYTHONPATH .= expand(":$RMUXDIR/jedi")
````

## Additional content ##

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

## SSH tricks ##

The recommended settings will keep a master connection to the server open. You can close it
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

## Bash history ##

The template bashrc shares the bash history across bash-sessions and cleans the
history to contain only unique lines. Use ctrl-r to access the history.

Remove the section in the bashrc if you don't want this feature.

If you don't share ~/.bashrc you can copy the unique history settings from 
~/.rmux-\<id\>/templates/bashrc to get the feature on your localhost as well.

## Example for rmux-\<id\> directory ##

````bash
$> ls -lh
total 3896
-rw-r--r--  1 ganwell  staff    56B Feb 27 22:23 README
-rw-r--r--  1 ganwell  staff   5.0K Feb 28 22:56 README.md
-rw-------  1 ganwell  staff   175K Feb 28 23:09 bash_history
-rwxr-xr-x  1 ganwell  staff   1.2K Feb 27 23:15 bashrc
drwxr-xr-x  4 ganwell  staff   136B Feb 28 22:56 bin
-rwxr-xr-x  1 ganwell  staff   832B Feb 28 22:24 init
-rwxr-xr-x  1 ganwell  staff    41B Feb 27 21:23 init-templates.sh
-rw-r--r--  1 ganwell  staff   175K Feb 28 22:56 my_history
-rwxr-xr-x  1 ganwell  staff    79B Feb 27 21:29 rmuxid
drwxr-xr-x  8 ganwell  staff   272B Feb 28 22:27 templates
-rwxr-xr-x  1 ganwell  staff   1.5M Feb 27 21:23 tmux-bin
-rwxr-xr-x  1 ganwell  staff   570B Feb 28 22:56 tmux-start
lrwxr-xr-x  1 ganwell  staff    25B Feb 27 21:44 tmux.conf -> /Users/ganwell/.tmux.conf
-rwxr-xr-x  1 ganwell  staff   869B Feb 27 23:14 unique_history.py
lrwxr-xr-x  1 ganwell  staff    19B Feb 27 21:44 vim -> /Users/ganwell/.vim
lrwxr-xr-x  1 ganwell  staff    21B Feb 27 21:44 vimrc -> /Users/ganwell/.vimrc
````

Authors

* https://github.com/ganwell
* https://github.com/schtibe
