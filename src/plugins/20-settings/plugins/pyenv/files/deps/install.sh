source .config

if ! command -v pyenv; then
  if [ -x "$HOME/.pyenv/bin/pyenv" ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
  else
    echo "PYENV NOT FOUND"
    exit 1
  fi
fi

eval "$(pyenv init -)"

if [ ! -e  "$(pyenv root)"/plugins/pyenv-install-latest ]; then
  (set -x; git clone https://github.com/momo-lab/pyenv-install-latest.git "$(pyenv root)"/plugins/pyenv-install-latest)
fi

if [ ! -e  "$(pyenv root)"/plugins/pyenv-virtualenv ]; then
  (set -x; git clone https://github.com/pyenv/pyenv-virtualenv "$(pyenv root)"/plugins/pyenv-virtualenv)
fi

# PYTHON 2
if ! compgen -G "$HOME/.pyenv/versions/2.*" > /dev/null; then
  (set -x; pyenv install-latest 2)
fi

if [ ! -e ~/.pyenv/versions/$python2_env ]; then
  v=$(cd $(pyenv root)/versions; ls -d 2.* | sort -n | tail -1)
  (set -x; pyenv virtualenv $v $python2_env)
fi

echo pyenv shell $python2_env
pyenv shell $python2_env
(set -x; pip2 install --upgrade pip neovim)

echo "let g:python_host_prog='$(pyenv which python)'" > vimrc.pyenv

# PYTHON 3
if ! compgen -G "$HOME/.pyenv/versions/3.*" > /dev/null; then
  (set -x; pyenv install-latest 3)
fi

if [ ! -e ~/.pyenv/versions/$python3_env ]; then
  v=$(cd $(pyenv root)/versions; ls -d 3.* | sort -n | tail -1)
  (set -x; pyenv virtualenv $v $python3_env)
fi

echo pyenv shell $python3_env
pyenv shell $python3_env
(set -x; pip3 install --upgrade pip neovim)

echo "let g:python3_host_prog='$(pyenv which python)'" >> vimrc.pyenv
