desc <<END
if you are using different python environments it's best to create 2 separate
environments, one for python2, and another for python3
END
if ask_bool pyenv "Setup pyenv integration?" y; then
  ask string python2_env "pyenv environment for python2" vim-python2
  ask string python3_env "pyenv environment for python3" vim-python3
else
  false
fi
