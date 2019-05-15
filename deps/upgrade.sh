
# src/plugins/00-cleanup/files/deps/upgrade.sh -------------------

source .config

# src/plugins/20-settings/plugins/interpreters/files/deps/upgrade.sh -------------------

# PYTHON2

export PYTHONWARNINGS="ignore:DEPRECATION"

if [ -n "$vim_pip2" ]; then
  (set -x; $vim_pip_sudo $vim_pip2 install --upgrade neovim)
fi

# PYTHON3

if [ -n "$vim_pip3" ]; then
  (set -x; $vim_pip_sudo $vim_pip3 install --upgrade neovim)
fi

# RUBY

if [ -n "$vim_gem" ]; then
  (set -x; $vim_gem_sudo $vim_gem install neovim)
fi

# NODE

if [ -n "$vim_yarn" ]; then
  (set -x; $vim_yarn global add neovim)
fi

# src/plugins/30-general/plugins/vimwiki/files/deps/upgrade.sh -------------------

# PYTHON3

if [ -n "$vim_pip3" ]; then
  (set -x; $vim_pip_sudo $vim_pip3 install --uptrade six git+git://github.com/robgolding63/tasklib@develop)
fi

# src/plugins/40-completion/engine/deoplete/plugins/ruby-solargraph/files/deps/upgrade.sh -------------------

if [ '-' != "$vim_gem" ]; then
  (set -x; $vim_gem_sudo $vim_gem install solargraph)
fi
