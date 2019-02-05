#!/usr/bin/env bash

# Powerline fonts https://github.com/powerline/fonts
git clone https://github.com/powerline/fonts.git --depth=1 ~/fonts
cd "${HOME}"/fonts || exit 1
./install.sh
cd "${HOME}" || exit 1
rm -rf ~/fonts

