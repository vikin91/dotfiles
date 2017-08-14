if ! is-macos -o ! is-executable ruby -o ! is-executable curl -o ! is-executable git; then
  echo "Skipped: Homebrew (missing: ruby, curl and/or git)"
  return
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade

# Install packages

apps=(
  ack
  bash-completion2
  colordiff
  coreutils
  ffmpeg
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

brew install "${apps[@]}"
 
# export DOTFILES_BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
# set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"
# 
# ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~
