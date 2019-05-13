# PYTHON2

if [ '-' != "$vim_pip2" ]; then
  if ! $vim_pip2 show neovim > /dev/null; then
    (set -x; $vim_pip_sudo $vim_pip2 install neovim)
  fi
fi

# PYTHON3

if [ '-' != "$vim_pip3" ]; then
  if ! $vim_pip3 show neovim > /dev/null; then
    (set -x; $vim_pip_sudo $vim_pip3 install neovim)
  fi
fi

# RUBY

if [ '-' != "$vim_gem" ]; then
  if ! command -v neovim-ruby-host > /dev/null; then
    (set -x; $vim_gem_sudo $vim_gem install neovim)
  fi
fi

# NODE

if [ '-' != "$vim_yarn" ]; then
  if ! command -v neovim-node-host > /dev/null; then
    (set -x; $vim_yarn global add neovim)
  fi
fi
