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
  if is-executable git -a -d "$DOTFILES_DIR/.git" ; then
    git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master;
  fi

  install_and_enable_zsh
  install_vundle

  # Install .dotfiles by symlinking
  backup_and_link_dotfile ".vimrc"
  backup_and_link_dotfile ".editorconfig"
  backup_and_link_dotfile ".gitconfig"
  backup_and_link_dotfile ".git-templates"
  backup_and_link_dotfile ".zshrc"

  shall_install_brew && install_brew
  shall_install_perl && install_perl


  ### SANDBOX - TO REFACTOR

  # Install bat - colorful version of cat
  if is_linux; then
    command -v wget && wget -q "https://github.com/sharkdp/bat/releases/download/v0.9.0/bat-musl_0.9.0_amd64.deb"
    command -v curl && curl --silent --show-error "https://github.com/sharkdp/bat/releases/download/v0.9.0/bat-musl_0.9.0_amd64.deb" --output "bat-musl_0.9.0_amd64.deb"
    sudo dpkg -i bat-musl_0.9.0_amd64.deb
  fi

  # Install fzf
  if [ ! "$(command -v fzf)" ]; then
    git clone --depth 1 "https://github.com/junegunn/fzf.git" "$HOME/.fzf"
    sleep 1
    [ -f "${HOME}/.fzf/install" ] && "${HOME}/.fzf/install" --all
    # shellcheck source=~/.zshrc
    source "${HOME}/.zshrc"
  fi

# echo "Running other installs"
# source "$DOTFILES_DIR/install/other.sh"
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

function shall_install_perl(){
  [ "${PARAM}" == 'all' ] || [ "${PARAM}" == 'perl' ]
}

function install_perl(){
  if [ "$PARAM" = "perl" ]; then
    echo "Running perl installs"
    source "$DOTFILES_DIR/install/perl.sh"
  fi
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

  # ZSH themes cannot be linked, must be copied
  mkdir -p "${HOME}/.oh-my-zsh/custom/themes/lambda/"
  cp "$DOTFILES_DIR/zsh-themes/lambda-mod.zsh-theme" ~/.oh-my-zsh/custom/themes/lambda/
}

function install_vundle(){
  # Install vundle pkg manager for vim
  if [ ! -d "${HOME}/.vim/bundle/Vundle.vim" ]; then
    echo "Installing Vundle for vim"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
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
