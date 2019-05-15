# PYTHON3

if [ -n "$vim_pip3" ]; then
  if ! $vim_pip3 show tasklib > /dev/null; then
    (set -x; $vim_pip_sudo $vim_pip3 install git+git://github.com/robgolding63/tasklib@develop)
  fi

  if ! $vim_pip3 show six > /dev/null; then
    (set -x; $vim_pip_sudo $vim_pip3 install six)
  fi
fi
