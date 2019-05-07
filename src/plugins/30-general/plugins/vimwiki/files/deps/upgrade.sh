if [ 'y' == "$use_pyenv" ]; then
  echo using $pyenv3 pyenv
  pyenv shell $pyenv3
fi

(set -x; pip3 install --upgrade  six git+git://github.com/robgolding63/tasklib@develop)
