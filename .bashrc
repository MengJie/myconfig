EDITOR=vim;   	export EDITOR
PAGER=less;  	export PAGER
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/X11R6/bin:$HOME/bin:/home/jie/bin; export PATH

LC_ALL=zh_CN.UTF-8;	export LC_ALL
#LANG="zh_CN.GBK";	export LANG
TERM="xterm-256color"; export TERM
alias ls='ls -G'
alias la='ls -Ga'
alias ll='ls -lT'
alias l="ls -lT"
alias vi='vim'
alias em='emacs'

alias dev='cd /home/jie/dev-link'
alias engine='cd /home/jie/dev-link/engine'
alias common='cd /home/jie/dev-link/logic/common'
alias logic='cd /home/jie/dev-link/logic'
alias tools='cd /home/jie/dev-link/logic/tools'
alias tclient='cd /home/jie/dev-link/engine/test/tclient'
alias xls='cd /home/jie/dev-link/logic/xls'

#export PS1="\$?-[\u]:\w>"
export PS1="[\u \w] :-) "
#set -o vi

if [ -f $HOME/.termcap ]; then
	TERMCAP=$(< $HOME/.termcap)
	export TERMCAP
fi

export GOROOT=$HOME/go
export GOROOT_FINAL=/usr/local/go
export GOBIN=/usr/local/bin
export GOOS=freebsd
export GOARCH=386
PATH=$GOBIN:$PATH; export PATH

source /usr/local/etc/bash_completion
source ~/.git-completion.bash

