load(){
  if [ -f "$1" ]; then
    . "$1"
  fi
}

resrc() {
  . ~/.zshrc
}

# export ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="robbyrussell"
# export UPDATE_ZSH_DAYS=7
# DISABLE_AUTO_TITLE="true"

fpath=(~/.zsh/completion $fpath)
plugins=(git osx docker kubectl)
# source $ZSH/oh-my-zsh.sh

# User configuration
#
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
#
# GPG TTY setup
GPG_TTY=$(tty)
export GPG_TTY

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ll="ls -l"
alias lla="ls -la"

alias k="kubectl"
alias ks="kubectl -n stackrox"
alias ocs="oc -n stackrox"

alias gco="git checkout"
alias grb="git rebase"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"
alias livetree="watch --color -n1 git log --oneline --decorate --all --graph --color=always"
alias gitmasterprune="git checkout master && git pull && git fetch --prune"
# alias gitmainprune="git checkout main && git pull && git fetch --prune"
#
[ -f ~/.config/rox ] && source ~/.config/rox

function gitkillbranches(){
    git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D
}
# Edit command in vim
export EDITOR=$(command -v vim)
# export VISUAL=$(command -v vim)

# autoload -U edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line
# allows to hit esc + v to enter vim visual mode for the current command
# set -o vi

# Go config
export GOPATH="${HOME}/go"
# Go installed from pkg
test -d "/usr/local/go" && export GOROOT="/usr/local/go"
# Go installed from brew
test -d "/usr/local/opt/go/libexec" && export GOROOT="/usr/local/opt/go/libexec"

export PATH="/usr/local/sbin:/usr/local/bin:${HOME}/bin:$GOPATH/bin:$GOROOT/bin:/opt/homebrew/bin:$PATH"
export LANG=en_US.UTF-8
export LC_ALL=$LANG

function countLoc(){
  local DEST
  [ "$(command -v cloc)" ] && \
    DEST="$(mktemp -d)" && \
    [ -d "$DEST" ] && rm -f "${DEST}/*" && \
    git clone --depth 1 "$1" "$DEST" && \
    cloc "$DEST"
}


[ "$(which)" ] && export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Add visual studio code to PATH
export PATH="$PATH":'/Applications/Visual Studio Code.app/Contents/Resources/app/bin'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ -f ~/.p10k.zsh ] && source "$HOME/.p10k.zsh"
[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# tells shell to not store in history such commands that start with space (and skip duplicates)
HISTCONTROL=ignoreboth
HISTSIZE=50000
HISTFILE="${HOME}/.zsh_history"
# https://linux.die.net/man/1/zshoptions
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE

load "${HOME}/.iterm2_shell_integration.zsh"
load "${HOME}/Library/Preferences/org.dystroy.broot/launcher/bash/br"
load "$HOME/.fzf.zsh"

rm -f "/usr/local/share/zsh/site-functions/_brew"
if [ -f "/opt/homebrew/completions/zsh/_brew" ]; then
  ln -s "/opt/homebrew/completions/zsh/_brew" "/usr/local/share/zsh/site-functions/_brew"
fi

rm -f "/usr/local/share/zsh/site-functions/_brew_cask"
if [ -f "/opt/homebrew/completions/zsh/_brew_cask" ]; then
  ln -s "/opt/homebrew/completions/zsh/_brew_cask" "/usr/local/share/zsh/site-functions/_brew_cask"
fi

rm -f "/usr/local/share/zsh/site-functions/_brew_services"
if [ -f "/opt/homebrew/completions/zsh/_brew_services" ]; then
  ln -s "/opt/homebrew/completions/zsh/_brew_services" "/usr/local/share/zsh/site-functions/_brew_services"
fi

eval "$(starship init zsh)"

# Makefile targets autocompletion
zstyle ':completion:*:*:make:*' tag-order 'targets'
autoload -U compinit && compinit
# new version of SSH - https://aditsachde.com/posts/yubikey-ssh/
# SSH_AUTH_SOCK="~/.ssh/agent" # disallows Docker to mount SSH_AUTH_SOCK from the host

# The next line updates PATH for the Google Cloud SDK.
load "$HOME/code/google-cloud-sdk/path.zsh.inc"

# The next line enables shell command completion for gcloud.
load "$HOME/code/google-cloud-sdk/completion.zsh.inc"
load "$HOME/go/src/github.com/stackrox/workflow/env.sh"


# enable Emacs mode in zsh
bindkey -e

# search with up/down-arrow in history: https://superuser.com/questions/585003/searching-through-history-with-up-and-down-arrow-in-zsh
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
# bindkey "$key[Up]" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search
# bindkey "$key[Down]" down-line-or-beginning-search # Down

load "$HOME/.config/broot/launcher/bash/br"

SSH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add "$HOME/.ssh/id_ed25519"
}

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep "${SSH_AGENT_PID}" | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
