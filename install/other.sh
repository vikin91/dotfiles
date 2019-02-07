#!/usr/bin/env bash

# Powerline fonts https://github.com/powerline/fonts
TMP_FONT_DIR="/tmp/fonts"
mkdir -p "${TMP_FONT_DIR}"
git clone https://github.com/powerline/fonts.git --depth=1 "${TMP_FONT_DIR}"
cd "${TMP_FONT_DIR}" || exit 1
./install.sh
cd "${TMP_FONT_DIR}" || exit 1
rm -rf "${TMP_FONT_DIR}"

