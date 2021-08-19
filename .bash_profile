# .bash_profile - making bash that much better

unset USERNAME
if [ "$HOME" = "" ]; then
    echo "No HOME found, setting one"
    export HOME=~
fi

export EDITOR=vim
PATH=/usr/local:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11/bin:~/bin:/usr/local/mysql/bin:/opt/go/bin:.
if [ $TERM != linux ]; then
  PATH=$PATH:/Users/ashone/go/bin:/Users/ashone:/Users/ashone/.composer/vendor/bin:/Users/ashone/.opam/system/bin:/Users/ashone/.yarn/bin:/Users/ashone/.cargo/bin:/Users/ashone/go/bin
else
  PATH=$PATH:/home/ashone/go/bin:/home/ashone:/home/ashone/.composer/vendor/bin:/home/ashone/.opam/system/bin:/home/ashone/.yarn/bin:/home/ashone/.cargo/bin:/home/ashone/go/bin
fi
export PATH

export CLICOLOR=1
export TERM=xterm-256color

function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

if [ "`uname`" = "Linux" ]; then
  alias la="ls -la --color=auto"
  alias lg="ls -gahS --color=auto"
  alias lr="ls -lart --color=auto"
else
  alias la="ls -la "
  alias lg="ls -gahS "
  alias lr="ls -lart "
fi
alias hist="sort | uniq -c | sort -nr"

# doge git
alias wow="git status"
alias such="git $*"
alias very="git $*"
alias ic="git-icdiff"

alias twork='terraform workspace select'
alias tplan='terraform plan -parallelism=80 -out /tmp/tplan'
alias tapply='terraform apply /tmp/tplan'

# run direnv setup
eval "$(direnv hook bash)"

if [ -f "$(which terraform-docs)" ]; then
  source <(terraform-docs completion bash)
fi

# opam configuration
if [ -f ~/.opam/opam-init/init.sh ]; then
  . ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
fi

# non-checked in profile script
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi

if [ -f /usr/local/share/chtf/chtf.sh ]; then
  . /usr/local/share/chtf/chtf.sh
fi

#function dock-php() {
#  DIR=$(readlink -f $(pwd))
#  ARGS=$*
#  docker run --rm -v "$DIR":/app -w /app php php $ARGS
#}

# simpler master update for git
function gitu {
    BRANCH=${1:-main}
    BRANCH_TWO=${2:-main}
    git checkout "$BRANCH" && git fetch origin && git merge --ff-only origin/"$BRANCH_TWO"
}

# update and rebase
function gitr {
    ORIG_BRANCH="$(git st | cut -f3 -d' ' | head -n 1)"
    gitu # update master from origin
    git checkout "$ORIG_BRANCH" # move back to the original branch
    git rebase -i master # pull in the commits from master to the branch
}

