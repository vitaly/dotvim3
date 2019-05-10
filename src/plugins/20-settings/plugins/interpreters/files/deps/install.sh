# PYTHON2

if [ '-' != "$vim_pip2" ]; then
  if ! $vim_pip2 show neovim; then
    (set -x; $vim_pip2 install neovim)
  fi
fi

# PYTHON3

if [ '-' != "$vim_pip3" ]; then
  if ! $vim_pip3 show neovim; then
    (set -x; $vim_pip3 install neovim)
  fi
fi

# RUBY

if [ '-' != "$vim_gem" ]; then
  if ! command -v neovim-ruby-host; then
    (set -x; $vim_gem install neovim)
  fi
fi

# NODE

if [ '-' != "$vim_yarn" ]; then
  if ! command -v neovim-node-host; then
    (set -x; $vim_yarn global add neovim)
  fi
fi
