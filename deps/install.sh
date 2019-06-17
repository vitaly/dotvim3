
# src/plugins/00-cleanup/files/deps/install.sh -------------------

source .config

# src/plugins/20-settings/plugins/interpreters/files/deps/install.sh -------------------

# PYTHON2

export PYTHONWARNINGS="ignore:DEPRECATION"

if [ '-' != "$vim_pip2" ]; then
  if ! $vim_pip2 show neovim > /dev/null; then
    (set -x; $vim_pip_sudo $vim_pip2 install neovim)
  fi
fi

# PYTHON3

if [ '-' != "$vim_pip3" ]; then
  if ! $vim_pip3 show neovim > /dev/null; then
    (set -x; $vim_pip_sudo $vim_pip3 install neovim)
  fi
fi

# RUBY

if [ '-' != "$vim_gem" ]; then
  if ! command -v neovim-ruby-host > /dev/null; then
    (set -x; $vim_gem_sudo $vim_gem install neovim)
  fi
fi

# NODE

if [ '-' != "$vim_yarn" ]; then
  if ! command -v neovim-node-host > /dev/null; then
    (set -x; $vim_yarn global add neovim)
  fi
fi

# src/plugins/30-general/plugins/vimwiki/files/deps/install.sh -------------------

# PYTHON3

if [ -n "$vim_pip3" ]; then
  if ! $vim_pip3 show tasklib > /dev/null; then
    (set -x; $vim_pip_sudo $vim_pip3 install git+git://github.com/robgolding63/tasklib@develop)
  fi

  if ! $vim_pip3 show six > /dev/null; then
    (set -x; $vim_pip_sudo $vim_pip3 install six)
  fi
fi

# src/plugins/40-ide/plugins/10-completion/engine/coc/files/deps/install.sh -------------------

# COC EXTENSIONS
EXTENSIONS=(
coc-git
coc-gocode
coc-json
coc-lists
coc-snippets
coc-solargraph
coc-syntax
coc-tag
coc-tsserver
coc-yank
)

vim +"CocInstall -sync ${EXTENSIONS[*]}" "+qa"

# JS & TYPESCRIPT LSP
if [ '-' != "$vim_yarn" ]; then
  if ! command -v javascript-typescript-stdio > /dev/null; then
    (set -x; $vim_yarn global add javascript-typescript-langserver)
  fi
  if ! command -v typescript-language-server > /dev/null; then
    (set -x; $vim_yarn global add typescript-language-server)
  fi
fi

# RUBY LSP
if [ '-' != "$vim_gem" ]; then
  if ! command -v solargraph > /dev/null; then
    (set -x; $vim_gem_sudo $vim_gem install solargraph)
  fi
fi

# BASH
if [ '-' != "$vim_yarn" ]; then
  if ! command -v bash-language-server > /dev/null; then

    (set -x; $vim_yarn global add bash-language-server)
  fi
fi
