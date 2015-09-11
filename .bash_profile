
PATH=/bin:/usr/local:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11/bin:/home/allans/bin:/usr/local/mysql/bin:/home/y/bin:/home/allans:/usr/local/go/bin:/Users/allans/Documents/go/bin
export PATH

unset USERNAME

export GOPATH=/Users/allans/Documents/go/
export CLICOLOR=1
export TERM=xterm-256color
export gnarleyHostName=`hostname | cut -d\.  -f1`
export PS1="[\[\e[37;1m\]\u\[\e[31;1m\]@\[\e[37;1m\]$gnarleyHostName\[\e[0m\]]\[\e[32m\] \w/$\[\e[0m\] "
export WATCHDIR=home:/share/CACHEDEV1_DATA/Download/transmission/watch/

alias lg="ls -gahS"
alias la="ls -la"
alias hist="sort | uniq -c | sort -nr"

alias wow="git status"
alias such="git"
alias very="git"

