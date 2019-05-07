if [ 'y' == "$pip_sudo" ]; then
  PIP_SUDO="sudo -E -H"
else
  PIP_SUDO=
fi

if [ 'y' == "$use_pyenv" ]; then
  echo using $pyenv3 pyenv
  pyenv shell $pyenv3
fi

(set -x; $PIP_SUDO pip3 install --upgrade  six git+git://github.com/robgolding63/tasklib@develop)
