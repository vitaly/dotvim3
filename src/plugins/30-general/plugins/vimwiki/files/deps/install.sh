if [ 'y' == "$use_pyenv" ]; then
  echo using $pyenv3 pyenv
  pyenv shell $pyenv3
fi

if ! pip3 list | grep tasklib; then
  (set -x; pip3 install git+git://github.com/robgolding63/tasklib@develop)
fi

if ! pip3 list | grep six; then
  (set -x; pip3 install six)
fi
