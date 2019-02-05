#!/usr/bin/env bash

# Perl
export LANG='en_US.UTF-8'
export LC_ALL="$LANG"
export LC_CTYPE=en_US.UTF-8

# It makes perl automatically answer "yes" when CPAN asks "Would you like to configure as much as possible automatically? [yes]"
export PERL_MM_USE_DEFAULT=1

if [ ! "$(which perlbrew)" ]; then
  curl -L https://install.perlbrew.pl | bash
  grep -q -F 'source ~/perl5/perlbrew/etc/bashrc' "${HOME}/.zshenv" || echo 'source ~/perl5/perlbrew/etc/bashrc' >> ~/.zshenv
  source "$HOME/.zshenv"
else
  echo "Perlbrew already installed, skipping."
fi

perlbrew init
STATUS=$(perlbrew install perl-5.22.3)
if [ "$STATUS" = 0 ]; then
  perlbrew switch perl-5.22.3
  sudo chown -R "$(whoami)" "${HOME}/perl5"
fi

if [ ! -f "${HOME}perl5/perlbrew/bin/cpanm" ]; then
  perlbrew install-cpanm
  # Cpanm will install libs without root access to local path
else
  echo "Cpanm is already installed. Skipping"
fi
# Install essential perl libraries
cpanm -nq Perl::Tidy Code::TidyAll

ln -sfv "$DOTFILES_DIR/.tidyallrc" $HOME
ln -sfv "$DOTFILES_DIR/.perltidyrc" $HOME
