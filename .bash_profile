# .bash_profile - making bash that much better

unset USERNAME
if [ "$HOME" = "" ]; then
    echo "No HOME found, setting one"
    export HOME=~
fi

# can has keyboard lights
xset led 3

export GOPATH=/opt/go
PATH=/bin:/usr/local:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11/bin:~/bin:/usr/local/mysql/bin:/home/y/bin:/home/y/bin64:~:/usr/local/go/bin:$GOPATH/bin:~/.composer/vendor/bin
export PATH

export GOROOT=$GOPATH
export GOPATH=$GOPATH/
export CLICOLOR=1
export TERM=xterm-256color
export gnarleyHostName=`hostname | cut -d\.  -f1`
export PS1="[\[\e[37;1m\]\u\[\e[31;1m\]@\[\e[37;1m\]$gnarleyHostName\[\e[0m\]]\[\e[32m\] \w/$\[\e[0m\] "
export PS1="\[\e[01;35m\]\u\[\e[0m\]\[\e[01;37m\]@\h\[\e[0m\]\[\e[00;37m\]:\w \[\e[0m\]\[\e[00;36m\]$?\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[01;37m\]\n$\[\e[0m\]\[\e[00;37m\] \[\e[0m\]"

alias la="ls -la --color=auto"
alias lg="ls -gahS --color=auto"
alias ls="ls -G --color=auto"
alias lr="ls -lart --color=auto"
alias hist="sort | uniq -c | sort -nr"

# doge git
alias wow="git status"
alias such="git $*"
alias very="git $*"

# run direnv setup
eval "$(direnv hook bash)"

#function dock-php() {
#  DIR=$(readlink -f $(pwd))
#  ARGS=$*
#  docker run --rm -v "$DIR":/app -w /app php php $ARGS
#}

# simpler master update for git
function gitu {
    BRANCH=${1:-master}
    git checkout "$BRANCH" && git fetch origin && git merge --ff-only origin/"$BRANCH"
}
