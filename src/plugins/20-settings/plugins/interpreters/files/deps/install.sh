# RUBY

if [ -n "$vim_gem" ]; then
  if ! $vim_gem which neovim; then
    (set -x; $vim_gem install neovim)
  fi
fi

# PYTHON2

if [ -n "$vim_pip2" ]; then
  if ! $vim_pip2 show neovim; then
    (set -x; $vim_pip2 install neovim)
  fi
fi

# PYTHON3

if [ -n "$vim_pip3" ]; then
  if ! $vim_pip3 show neovim; then
    (set -x; $vim_pip3 install neovim)
  fi
fi

# NODE

if [ -n "$vim_yarn" ]; then
  if ! command -v neovim-node-host; then
    (set -x; $vim_yarn global add neovim)
  fi
fi
