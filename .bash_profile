# .bash_profile - making bash that much better

unset USERNAME
<<<<<<< HEAD
if [ "${HOME}" = "" ]; then
    echo "No HOME found, setting one"
    export HOME=~
||||||| parent of 9a916f2 (Just push through)
if [ "$HOME" = "" ]; then
    echo "No HOME found, setting one"
    export HOME=~
=======
if [ "$HOME" = "" ]; then
  echo "No HOME found, setting one"
  export HOME=~
>>>>>>> 9a916f2 (Just push through)
fi

<<<<<<< HEAD
export EDITOR=vim
PATH=/usr/local/opt/python\@3.7/bin:/usr/local:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11/bin:~/bin:/usr/local/mysql/bin:/opt/go/bin:.
if [ "${TERM}" != "linux" -a "${TERM}" != "xterm-256color" ]; then
  PATH=/opt/homebrew/bin:$PATH:/Users/ashone/go/bin:/Users/ashone:/Users/ashone/.composer/vendor/bin:/Users/ashone/.opam/system/bin:/Users/ashone/.yarn/bin:/Users/ashone/.cargo/bin:/Users/ashone/go/bin
||||||| parent of 9a916f2 (Just push through)
export EDITOR=vim
PATH=/usr/local/opt/python\@3.7/bin:/usr/local:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11/bin:~/bin:/usr/local/mysql/bin:/opt/go/bin:.
if [ $TERM != linux ]; then
  PATH=$PATH:/Users/ashone/go/bin:/Users/ashone:/Users/ashone/.composer/vendor/bin:/Users/ashone/.opam/system/bin:/Users/ashone/.yarn/bin:/Users/ashone/.cargo/bin:/Users/ashone/go/bin
=======
export EDITOR=nvim
PATH=${HOME}/.opencode/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/libpq/bin:/usr/local/opt/python\@3.7/bin:/usr/local:/usr/local/bin:/bin:/usr/bin:/usr/sbin:/sbin:/usr/X11/bin:~/bin:/usr/local/mysql/bin:/opt/go/bin:.
if [ $TERM != linux ]; then
  PATH=$PATH:/Users/ashone/go/bin:/Users/ashone:/Users/ashone/.composer/vendor/bin:/Users/ashone/.opam/system/bin:/Users/ashone/.yarn/bin:/Users/ashone/.cargo/bin:/Users/ashone/go/bin
>>>>>>> 9a916f2 (Just push through)
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

if [ "$(uname)" = "Linux" ]; then
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
alias ic="git diff"

alias twork='terraform workspace select'
alias tplan='terraform plan -parallelism=80 -out /tmp/tplan'
alias tapply='terraform apply /tmp/tplan'
alias tfwl='terraform workspace list'

# run direnv setup
eval "$(direnv hook bash)"

# run mise setup
if [ -f ~/.local/bin/mise ]; then
  eval "$(~/.local/bin/mise activate bash)"
fi

if [ -f "$(which terraform-docs)" ]; then
  source <(terraform-docs completion bash)
fi

# opam configuration
if [ -f ~/.opam/opam-init/init.sh ]; then
  . ~/.opam/opam-init/init.sh >/dev/null 2>/dev/null || true
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
<<<<<<< HEAD
  git checkout "${BRANCH}" && git fetch origin && git merge --ff-only origin/"${BRANCH}"
||||||| parent of 9a916f2 (Just push through)
    BRANCH=${1:-main}
    BRANCH_TWO=${2:-main}
    git checkout "$BRANCH" && git fetch origin && git merge --ff-only origin/"$BRANCH_TWO"
=======
  BRANCH_TWO="${2:-main}"
  git checkout "${BRANCH}" && git fetch origin && git merge --ff-only origin/"${BRANCH_TWO}"
>>>>>>> 9a916f2 (Just push through)
}

# update and rebase
function gitr {
<<<<<<< HEAD
  BRANCH="${1:-develop}"
  ORIG_BRANCH="$(git st | cut -f3 -d' ' | head -n 1)"
  gitu "${BRANCH}"
  git checkout "${ORIG_BRANCH}"
  git rebase -i "${BRANCH}"
||||||| parent of 9a916f2 (Just push through)
    ORIG_BRANCH="$(git st | cut -f3 -d' ' | head -n 1)"
    gitu # update master from origin
    git checkout "$ORIG_BRANCH" # move back to the original branch
    git rebase -i master # pull in the commits from master to the branch
=======
  ORIG_BRANCH="$(git st | cut -f3 -d' ' | head -n 1)"
  gitu                          # update master from origin
  git checkout "${ORIG_BRANCH}" # move back to the original branch
  git rebase -i "${1:-main}"    # pull in the commits from master to the branch
>>>>>>> 9a916f2 (Just push through)
}

<<<<<<< HEAD
# non-checked in profile script
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
||||||| parent of 9a916f2 (Just push through)
=======
# force pull branch
function gitfp {
  branch="$(git branch --show-current)"
  git reset --hard "origin/${branch}"
  git pull
}

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
>>>>>>> 9a916f2 (Just push through)
