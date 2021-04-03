if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask

# Install packages

apps_common=(
  iterm2
)
apps_home=()

brew cask install "${apps_common[@]}"

