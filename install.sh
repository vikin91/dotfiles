#!/usr/bin/env bash

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
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
# Enable zsh as default shell
if [ "$SHELL" != '/bin/zsh' ];then
  chsh -s /bin/zsh
fi
# Install vundle pkg manager for vim
if [ ! -f ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Install .dotfiles by symlinking
ln -sfv "$DOTFILES_DIR/.vimrc" ~
ln -sfv "$DOTFILES_DIR/.editorconfig" ~
ln -sfv "$DOTFILES_DIR/.perltidyrc" ~
ln -sfv "$DOTFILES_DIR/.tidyallrc" ~
cp "${HOME}/.zshrc" "${HOME}/.zshrc_bak_$(date +%d-%m-%Y_%H-%M-%S)"
ln -sfv "$DOTFILES_DIR/.zshrc" ~
# ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
# ln -sfv "$DOTFILES_DIR/git/.gitignore_global" ~

# themes cannot be links
mkdir -p "${HOME}/.oh-my-zsh/custom/themes/lambda/"
cp "$DOTFILES_DIR/zsh-themes/lambda-mod.zsh-theme" ~/.oh-my-zsh/custom/themes/lambda/

# Package managers & packages
source "$DOTFILES_DIR/install/brew.sh"
# source "$DOTFILES_DIR/install/brew-cask.sh"
source "$DOTFILES_DIR/install/other.sh"

