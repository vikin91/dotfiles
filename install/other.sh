#!/usr/bin/env bash

# Perl
curl -L https://install.perlbrew.pl | bash
sudo cpan App::perlbrew
perlbrew install-cpanm
perlbrew init
perlbrew install perl-5.22.3
perlbrew switch perl-5.22.3
cpan perltidy
cpanm Code::TidyAll

