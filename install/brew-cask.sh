if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask

# Install packages

apps_common=(
  google-chrome
  slack
  sublime-text
  iterm2
)
apps_home=(
  dropbox
  google-drive
  spotify
  virtualbox
)

brew cask install "${apps_common[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize webpquicklook 

