
# export ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="robbyrussell"
# export UPDATE_ZSH_DAYS=7
# DISABLE_AUTO_TITLE="true"

fpath=(~/.zsh/completion $fpath)
plugins=(git osx docker docker-compose kubectl)
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

alias k=kubectl
alias gco="git checkout"
alias grb="git rebase"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"
alias livetree="watch --color -n1 git log --oneline --decorate --all --graph --color=always"
alias gitmasterprune="git checkout master && git pull && git fetch --prune"
alias gitmainprune="git checkout main && git pull && git fetch --prune"

function gitkillbranches(){
    git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D
}
# Edit command in vim
export EDITOR=$(command -v vim)
# export VISUAL=$(command -v vim)

# autoload -U edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

# Go config
export GOPATH=~/go/
export GOROOT=/usr/local/go/
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export PATH="/usr/local/sbin:/usr/local/bin:$HOME/bin:$PATH"
export PATH=/opt/homebrew/bin:$PATH
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

function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var home $(echo -n "$HOME")
}

[ "$(which)" ] && export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Add visual studio code to PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

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

# search with up/down-arrow in history: https://superuser.com/questions/585003/searching-through-history-with-up-and-down-arrow-in-zsh
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$key[Up]" up-line-or-beginning-search # Up
bindkey "$key[Down]" down-line-or-beginning-search # Down

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

test -e "${HOME}/Library/Preferences/org.dystroy.broot/launcher/bash/br" && source "${HOME}/Library/Preferences/org.dystroy.broot/launcher/bash/br"

# Use pip3 installed by brew
[ -d "/usr/local/Cellar/python/3.7.6_1/Frameworks/Python.framework/Versions/3.7/bin" ] && export PATH="/usr/local/Cellar/python/3.7.6_1/Frameworks/Python.framework/Versions/3.7/bin:$PATH"

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

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
SSH_AUTH_SOCK="~/.ssh/agent"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/prygiels/code/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/prygiels/code/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/prygiels/code/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/prygiels/code/google-cloud-sdk/completion.zsh.inc'; fi
