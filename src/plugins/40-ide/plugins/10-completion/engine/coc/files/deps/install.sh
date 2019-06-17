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
