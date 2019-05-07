
# src/plugins/00-cleanup/files/deps/install.sh -------------------

source .config

# src/plugins/20-settings/plugins/interpreters/files/deps/install.sh -------------------

# RUBY
if [ 'y' == "$neovim_ruby" ]; then
  if ! gem list neovim | grep -q neovim; then
    if [ 'y' == "$gem_sudo" ]; then
      GEM_SUDO="sudo -E -H"
    else
      GEM_SUDO=
    fi

    (set -x; $GEM_SUDO gem install neovim)
  fi
fi

# PYTHON
if [ 'y' == "$neovim_python" ]; then
  if [ 'y' == "$pip_sudo" ]; then
    PIP_SUDO="sudo -E -H"
  else
    PIP_SUDO=
  fi

  if [ 'y' == "$use_pyenv" ]; then
    eval "$(pyenv init -)"
  fi

  # python2
  if [ '' != "$python2" ]; then
    echo "let g:python_host_prog='$python2'" > vimrc.pyenv

    if [ 'y' == "$use_pyenv" ]; then
      echo using $pyenv2 pyenv
      pyenv shell $pyenv2
    fi

    if ! pip2 list | grep neovim; then
      $PIP_SUDO pip2 install neovim
    fi
  fi

  # python3
  if [ '' != "$python3" ]; then
    echo "let g:python3_host_prog='$python3'" >> vimrc.pyenv

    if [ 'y' == "$use_pyenv" ]; then
      echo using $pyenv3 pyenv
      pyenv shell $pyenv3
    fi

    if ! pip3 list | grep neovim; then
      $PIP_SUDO pip3 install neovim
    fi
  fi

fi

# NODE
if [ 'y' == "$neovim_js" ]; then
  if ! command -v neovim-node-host > /dev/null; then
    yarn global add neovim
  fi
fi

# src/plugins/30-general/plugins/vimwiki/files/deps/install.sh -------------------

if [ 'y' == "$pip_sudo" ]; then
  PIP_SUDO="sudo -E -H"
else
  PIP_SUDO=
fi

if [ 'y' == "$use_pyenv" ]; then
  echo using $pyenv3 pyenv
  pyenv shell $pyenv3
fi

if ! pip3 list | grep tasklib; then
  (set -x; $PIP_SUDO pip3 install git+git://github.com/robgolding63/tasklib@develop)
fi

if ! pip3 list | grep six; then
  (set -x; $PIP_SUDO pip3 install six)
fi
