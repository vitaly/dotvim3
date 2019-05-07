if [ 'y' == "$pip_sudo" ]; then
  PIP_SUDO="sudo -E"
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
