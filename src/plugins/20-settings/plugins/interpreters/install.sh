# RUBY
if ask_bool neovim_ruby "install neovim ruby gem?" y; then
  ask bool gem_sudo "should we use sudo with rubygems?" "n"
fi

# PYTHON
if ask_bool neovim_python "install python support packagess?" y; then
  ask bool pip_sudo "should we use sudo with pip?" "n"
  PY2=
  PY3=
  if ask_bool use_pyenv "uses python from  pyenv" y; then

    eval "$(pyenv init -)"

    ask string pyenv2 "virtual environment for python2 support" system
    pyenv shell $pyenv2
    if command -v python2 > /dev/null; then
      PY2=$(pyenv which python2)
    fi

    ask string pyenv3 "virtual environment for python3 support" system
    pyenv shell $pyenv3
    if command -v python3 > /dev/null; then
      PY3="$(pyenv which python3)"
    fi
  else
    # no pyenv

    if command -v python2 > /dev/null; then
      PY2="$(which python2)"
    fi

    if command -v python3 > /dev/null; then
      PY3="$(which python3)"
    fi
  fi

  if [ "" == "$PY2" ]; then
    warn "python2 executable not found"
  fi
  desc "leave empty to skip  python2 configuration"
  ask string python2 "python2" $PY2

  if [ "" == "$PY3" ]; then
    warn "python3 executable not found"
  fi
  desc "leave empty to skip  python3 configuration"
  ask string python3 "python3" $PY3
fi

# NODE
ask bool neovim_js "instsall nodejs support package?" y
