# RUBY

if [ -n "$vim_gem" ]; then
  "$vim_gem" install neovim
fi

# PYTHON2

if [ -n "$vim_pip2" ]; then
  "$vim_pip2" install --upgrade neovim
fi

# PYTHON3

if [ -n "$vim_pip3" ]; then
  "$vim_pip3" install --upgrade neovim
fi

# NODE

if [ -n "$vim_yarn" ]; then
  yarn global add neovim
fi
