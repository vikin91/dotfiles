if ! is-macos -o ! is-executable ruby -o ! is-executable curl -o ! is-executable git; then
  echo "Skipped: Homebrew (missing: ruby, curl and/or git)"
  return
fi

if [ ! "$(which brew)" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

# Install packages

apps=(
  ack
  bash-completion2
  colordiff
  coreutils
  ffmpeg
  fzf
  git
  gnu-sed --with-default-names
  grep --with-default-names
  imagemagick
  jq
  lynx
  perl
  rsync
  shellcheck
  ssh-copy-id
  tig
  tree
  vim
  watch
  wdiff
  wget
)

HOMEBREW_NO_AUTO_UPDATE=1 brew install "${apps[@]}"

# export DOTFILES_BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
# set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"
#
# ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~
