#!/usr/bin/env bash

PARAM=${1}

function is_macos(){
  test "$(uname)" = 'Darwin'
}

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR DOTFILES_CACHE DOTFILES_EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_CACHE="$DOTFILES_DIR/.cache.sh"
DOTFILES_EXTRA_DIR="$HOME/.extra"

# Load common functions
# shellcheck source=./lib.sh
source "$DOTFILES_DIR/lib.sh"

# Update dotfiles itself first

if is-executable git -a -d "$DOTFILES_DIR/.git" ; then
	git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master;
fi

# Vikin91 custom
# Install zsh
echo "Installing oh-my-zsh"
curl -L -s https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
# Enable zsh as default shell
if [ "$SHELL" != '/bin/zsh' ];then
  echo "Changing shell to zsh"
  chsh -s /bin/zsh
fi
# Install vundle pkg manager for vim
if [ ! -f "$HOME/.vim/bundle/Vundle.vim" ]; then
  echo "Installing Vundle for vim"
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Install .dotfiles by symlinking
ln -sfv "$DOTFILES_DIR/.vimrc" ~
ln -sfv "$DOTFILES_DIR/.editorconfig" ~
cp "${HOME}/.zshrc" "${HOME}/.zshrc_bak_$(date +%d-%m-%Y_%H-%M-%S)"
ln -sfv "$DOTFILES_DIR/.zshrc" ~

# themes cannot be links
mkdir -p "${HOME}/.oh-my-zsh/custom/themes/lambda/"
cp "$DOTFILES_DIR/zsh-themes/lambda-mod.zsh-theme" ~/.oh-my-zsh/custom/themes/lambda/

# Package managers & packages
if is_macos; then
  echo "Running brew installs"
  source "$DOTFILES_DIR/install/brew.sh"
  echo "Running brew-cask installs"
  source "$DOTFILES_DIR/install/brew-cask.sh"
fi

if [ "$PARAM" = "perl" ]; then
  echo "Running perl installs"
  source "$DOTFILES_DIR/install/perl.sh"
fi
echo "Running other installs"
source "$DOTFILES_DIR/install/other.sh"
