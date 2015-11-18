# .bash_profile - making bash that much better

unset USERNAME
if [ "$HOME" = "" ]; then
    echo "No HOME found, setting one"
    export HOME=~
fi

export GOPATH=~/Documents/go
PATH=/bin:/usr/local:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11/bin:~/bin:/usr/local/mysql/bin:/home/y/bin:/home/y/bin64:~:/usr/local/go/bin:$GOPATH/bin:~/.composer/vendor/bin
export PATH

export GOPATH=$GOPATH/
export CLICOLOR=1
export TERM=xterm-256color
export gnarleyHostName=`hostname | cut -d\.  -f1`
export PS1="[\[\e[37;1m\]\u\[\e[31;1m\]@\[\e[37;1m\]$gnarleyHostName\[\e[0m\]]\[\e[32m\] \w/$\[\e[0m\] "
export WATCHDIR=home:/share/CACHEDEV1_DATA/Download/transmission/watch/

alias la="ls -la --color=auto"
alias lg="ls -gahS --color=auto"
alias ls="ls -G --color=auto"
alias lr="ls -lart --color=auto"
alias hist="sort | uniq -c | sort -nr"

# doge git
alias wow="git status"
alias such="git $*"
alias very="git $*"

#function dock-php() {
#  DIR=$(readlink -f $(pwd))
#  ARGS=$*
#  docker run --rm -v "$DIR":/app -w /app php php $ARGS
#}

