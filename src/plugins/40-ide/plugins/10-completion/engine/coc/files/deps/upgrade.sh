# COC EXTENSIONS
vim +"CocUpdateSync"

# JS & TYPESCRIPT LSP
if [ '-' != "$vim_yarn" ]; then
  (set -x; $vim_yarn global add javascript-typescript-langserver)
  (set -x; $vim_yarn global add typescript-language-server)
fi

# RUBY LSP
if [ '-' != "$vim_gem" ]; then
  (set -x; $vim_gem_sudo $vim_gem install solargraph)
fi
