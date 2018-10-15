# .bash_profile - making bash that much better

unset USERNAME
if [ "$HOME" = "" ]; then
    echo "No HOME found, setting one"
    export HOME=~
fi

export EDITOR=vim
PATH=/bin:/usr/local:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11/bin:~/bin:/usr/local/mysql/bin:/home/y/bin:/home/y/bin64:~:/usr/local/go/bin:$GOPATH/bin:$GOROOT/bin:~/.composer/vendor/bin:/home/allan/e360/services/bin:/home/allan/.opam/system/bin:/usr/games:/opt/go/bin:/home/allan/go/bin:/home/allan/.cargo/bin
export PATH

export CLICOLOR=1
export TERM=xterm-256color

function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

alias la="ls -la --color=auto"
alias lg="ls -gahS --color=auto"
alias lr="ls -lart --color=auto"
alias hist="sort | uniq -c | sort -nr"

# doge git
alias wow="git status"
alias such="git $*"
alias very="git $*"
alias ic="git-icdiff"

# run direnv setup
eval "$(direnv hook bash)"

# opam configuration
. /home/allan/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

#function dock-php() {
#  DIR=$(readlink -f $(pwd))
#  ARGS=$*
#  docker run --rm -v "$DIR":/app -w /app php php $ARGS
#}

# simpler master update for git
function gitu {
    BRANCH=${1:-master}
    BRANCH_TWO=${2:-master}
    git checkout "$BRANCH" && git fetch origin && git merge --ff-only origin/"$BRANCH_TWO"
}

# update and rebase
function gitr {
    ORIG_BRANCH="$(git st | cut -f3 -d' ' | head -n 1)"
    gitu # update master from origin
    git checkout "$ORIG_BRANCH" # move back to the original branch
    git rebase -i master # pull in the commits from master to the branch
}

