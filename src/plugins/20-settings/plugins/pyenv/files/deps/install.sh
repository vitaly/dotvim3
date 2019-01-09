source .config

if [ ! -e  "$(pyenv root)"/plugins/pyenv-install-latest ]; then
  git clone https://github.com/momo-lab/pyenv-install-latest.git "$(pyenv root)"/plugins/pyenv-install-latest
fi

eval "$(pyenv init -)"

# PYTHON 2
if ! compgen -G "$HOME/.pyenv/versions/2.*" > /dev/null; then
  pyenv install-latest 2
fi

if [ ! -e ~/.pyenv/versions/$python2_env ]; then
  v=$(cd $(pyenv root)/versions; ls -d 2.* | sort -n | tail -1)
  pyenv virtualenv $v $python2_env
fi

pyenv shell $python2_env
pip2 install --upgrade pip neovim

echo "let g:python_host_prog='$(pyenv which python)'" > vimrc.pyenv

# PYTHON 3
if ! compgen -G "$HOME/.pyenv/versions/3.*" > /dev/null; then
  pyenv install-latest 3
fi

if [ ! -e ~/.pyenv/versions/$python3_env ]; then
  v=$(cd $(pyenv root)/versions; ls -d 3.* | sort -n | tail -1)
  pyenv virtualenv $v $python3_env
fi

pyenv shell $python3_env
pip3 install --upgrade pip neovim

echo "let g:python3_host_prog='$(pyenv which python)'" >> vimrc.pyenv
