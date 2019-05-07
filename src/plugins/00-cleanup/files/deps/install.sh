#!/bin/bash -e

if command -v gem > /dev/null; then
  if ! gem list neovim | grep -q neovim; then
    $GEM_SUDO gem install neovim
  fi
fi
