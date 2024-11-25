# .bash_profile - making bash that much better

unset USERNAME
if [ "${HOME}" = "" ]; then
    echo "No HOME found, setting one"
    export HOME=~
fi

export EDITOR=vim
PATH=/usr/local/opt/python\@3.7/bin:/usr/local:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11/bin:~/bin:/usr/local/mysql/bin:/opt/go/bin:.
if [ "${TERM}" != "linux" -a "${TERM}" != "xterm-256color" ]; then
  PATH=/opt/homebrew/bin:$PATH:/Users/ashone/go/bin:/Users/ashone:/Users/ashone/.composer/vendor/bin:/Users/ashone/.opam/system/bin:/Users/ashone/.yarn/bin:/Users/ashone/.cargo/bin:/Users/ashone/go/bin
else
  PATH=$PATH:/home/allan/go/bin:/home/allan:/home/allan/.composer/vendor/bin:/home/allan/.opam/system/bin:/home/allan/.yarn/bin:/home/allan/.cargo/bin:/usr/local/go/bin:/opt/nvim/bin
fi
export PATH

export CLICOLOR=1
export TERM=xterm-256color

function _update_ps1() {
  PS1=$(powerline-go $?)
}

if [[ "${TERM}" != linux && ! "${PROMPT_COMMAND}" =~ _update_ps1 ]]; then
  PROMPT_COMMAND="_update_ps1; ${PROMPT_COMMAND}"
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
alias tfwl='terraform workspace list'

# run direnv setup
eval "$(direnv hook bash)"

if [ -f "$(which terraform-docs)" ]; then
  source <(terraform-docs completion bash)
fi

# opam configuration
if [ -f ~/.opam/opam-init/init.sh ]; then
  . ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
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
  BRANCH="${1:-main}"
  git checkout "${BRANCH}" && git fetch origin && git merge --ff-only origin/"${BRANCH}"
}

# update and rebase
function gitr {
  BRANCH="${1:-develop}"
  ORIG_BRANCH="$(git st | cut -f3 -d' ' | head -n 1)"
  gitu "${BRANCH}"
  git checkout "${ORIG_BRANCH}"
  git rebase -i "${BRANCH}"
}

# non-checked in profile script
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
