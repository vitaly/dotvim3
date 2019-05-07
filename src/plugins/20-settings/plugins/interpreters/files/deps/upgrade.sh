# RUBY
if [ 'y' == "$neovim_ruby" ]; then
  if [ 'y' == "$gem_sudo" ]; then
    (set -x; sudo -E gem install neovim)
  else
    (set -x; gem install neovim)
  fi
fi

# PYTHON
if [ 'y' == "$neovim_python" ]; then
  if [ 'y' == "$use_pyenv" ]; then
    eval "$(pyenv init -)"
  fi

  # python2
  if [ '' != "$python2" ]; then
    if [ 'y' == "$use_pyenv" ]; then
      echo using $pyenv2 pyenv
      pyenv shell $pyenv2
    fi

    pip2 install --upgrade neovim
  fi

  # python3
  if [ '' != "$python3" ]; then
    if [ 'y' == "$use_pyenv" ]; then
      echo using $pyenv3 pyenv
      pyenv shell $pyenv3
    fi

    pip3 install --upgrade neovim
  fi

fi

# NODE
if [ 'y' == "$neovim_js" ]; then
  yarn global add neovim
fi
