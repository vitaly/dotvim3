# RUBY
if [ 'y' == "$neovim_ruby" ]; then
  if [ 'y' == "$gem_sudo" ]; then
    GEM_SUDO="sudo -E -H"
  else
    GEM_SUDO=
  fi

  (set -x; $GEM_SUDO gem install neovim)
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
    if [ 'y' == "$use_pyenv" ]; then
      echo using $pyenv2 pyenv
      pyenv shell $pyenv2
    fi

    $PIP_SUDO pip2 install --upgrade neovim
  fi

  # python3
  if [ '' != "$python3" ]; then
    if [ 'y' == "$use_pyenv" ]; then
      echo using $pyenv3 pyenv
      pyenv shell $pyenv3
    fi

    $PIP_SUDO pip3 install --upgrade neovim
  fi

fi

# NODE
if [ 'y' == "$neovim_js" ]; then
  yarn global add neovim
fi
