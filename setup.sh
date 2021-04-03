#!/usr/bin/env bash

PARAM=${1}
# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NOW="$(date +%d-%m-%Y_%H-%M-%S)"
BACKUP_DEST="${HOME}/.dotfiles_backups"
mkdir -p "${BACKUP_DEST}"
BACKUP_POSTFIX="dotfiles_setup_bak_${NOW}"

# Load common functions
# shellcheck source=./lib.sh
source "$DOTFILES_DIR/lib.sh"

function main(){
  # Update dotfiles itself first
  # if is-executable git -a -d "$DOTFILES_DIR/.git" ; then
  #   git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master;
  # fi

  install_and_enable_zsh || true
  install_vim_plug
  configure_iterm

  # Install ZSH theme
  [ -z "$ZSH_CUSTOM" ] && export ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

  # Install .dotfiles by symlinking
  backup_and_link_dotfile ".vimrc"
  backup_and_link_dotfile ".editorconfig"
  backup_and_link_dotfile ".gitconfig"
  backup_and_link_dotfile ".git-templates"
  backup_and_link_dotfile ".zshrc"

  shall_install_brew && install_brew


  ### SANDBOX - TO REFACTOR

  # Install bat - colorful version of cat
  if is_linux; then
    local _URL
    _URL="https://github.com/sharkdp/bat/releases/download/v0.12.1/bat-musl_0.12.1_amd64.deb"
    command -v wget && wget --quiet "${_URL}" --output-document="bat.deb"
    command -v curl && curl --location --silent --show-error "${_URL}" --output "bat.deb"
    [ -f bat.deb ] && sudo dpkg -i bat.deb
  fi

  # Install fzf
  if [ ! "$(command -v fzf)" ]; then
    git clone --depth 1 "https://github.com/junegunn/fzf.git" "$HOME/.fzf"
    sleep 1
    [ -f "${HOME}/.fzf/install" ] && "${HOME}/.fzf/install" --all
    # shellcheck source=~/.zshrc
    source "${HOME}/.zshrc"
  fi
}

function configure_iterm(){
  is_macos || return 1
  # Copy the fonts
  cp -f "$DOTFILES_DIR/fonts/*" "$HOME/Library/Fonts/"
  # Specify the preferences directory
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$DOTFILES_DIR"
  # Tell iTerm2 to use the custom preferences in the directory
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
}

function shall_install_brew(){
  is_macos || return 1
  [ "${PARAM}" == 'all' ] || [ "${PARAM}" == 'mac' ]
}

function install_brew(){
  # Package managers & packages
  echo "Running brew installs"
  source "$DOTFILES_DIR/install/brew.sh"
  echo "Running brew-cask installs"
  source "$DOTFILES_DIR/install/brew-cask.sh"
}

function install_and_enable_zsh(){
  # Install zsh
  echo "Installing oh-my-zsh"
  curl -L -s "https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh" | sh

  # Enable zsh as default shell
  if [ "${SHELL}" != '/bin/zsh' ];then
    echo "Changing shell to zsh"
    chsh -s /bin/zsh
  fi
}

function install_vim_plug(){
  # Install vundle pkg manager for vim
  if [ ! -d "${HOME}/.vim/autoload/plug.vim" ]; then
    echo "Installing Plug for vim"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}

function is_macos(){
  test "$(uname)" = 'Darwin'
}

function is_linux(){
  test "$(uname)" = 'Linux'
}

function backup_dotfile(){
  if [ -f "${HOME}/${1}" ]; then
    cp "${HOME}/${1}" "${BACKUP_DEST}/${1}_${BACKUP_POSTFIX}"
  elif [ -d "${HOME}/${1}" ]; then
    tar -cf "${BACKUP_DEST}/${1}_${BACKUP_POSTFIX}.tar" "${HOME}/${1}/"
  fi
}

function backup_and_link_dotfile(){
  backup_dotfile "${1}"
  ln -svf "$DOTFILES_DIR/${1}" "${HOME}"
}

main "$@"
