# RUBY
if [ 'y' == "$neovim_ruby" ]; then
  if ! gem list neovim | grep -q neovim; then
    if [ 'y' == "$gem_sudo" ]; then
      (set -x; sudo -E gem install neovim)
    else
      (set -x; gem install neovim)
    fi
  fi
fi

# PYTHON
if [ 'y' == "$neovim_python" ]; then
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
      pip2 install neovim
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
      pip3 install neovim
    fi
  fi

fi

# NODE
if [ 'y' == "$neovim_js" ]; then
  if ! command -v neovim-node-host > /dev/null; then
    yarn global add neovim
  fi
fi
