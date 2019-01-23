#!/bin/bash -e

if command -v gem > /dev/null; then
  if ! gem list neovim | grep -q neovim; then
    gem install neovim
  fi
fi
