
# src/plugins/00-cleanup/files/deps/install.sh -------------------

source .config

# src/plugins/20-settings/plugins/interpreters/files/deps/install.sh -------------------

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

# src/plugins/30-general/plugins/vimwiki/files/deps/install.sh -------------------

# PYTHON3

if [ -n "$vim_pip3" ]; then
  if ! $vim_pip3 show tassklib; then
    (set -x; $vim_pip3 install git+git://github.com/robgolding63/tasklib@develop)
  fi

  if ! $vim_pip3 show six; then
    (set -x; $vim_pip3 install six)
  fi
fi
