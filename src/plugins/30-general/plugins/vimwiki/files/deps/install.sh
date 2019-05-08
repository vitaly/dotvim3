# PYTHON3

if [ -n "$vim_pip3" ]; then
  if ! $vim_pip3 show tassklib; then
    $vim_pip3 install git+git://github.com/robgolding63/tasklib@develop
  fi

  if ! $vim_pip3 show six; then
    $vim_pip3 install six
  fi
fi
