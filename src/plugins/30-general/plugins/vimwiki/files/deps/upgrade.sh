# PYTHON3

if [ -n "$vim_pip3" ]; then
  (set -x; $vim_pip_sudo $vim_pip3 install --uptrade six git+git://github.com/robgolding63/tasklib@develop)
fi
