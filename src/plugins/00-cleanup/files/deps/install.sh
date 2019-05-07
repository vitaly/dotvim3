if command -v gem > /dev/null; then
  if ! gem list neovim | grep -q neovim; then
    (set -x; $GEM_SUDO gem install neovim)
  fi
fi
