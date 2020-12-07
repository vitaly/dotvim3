
# src/plugins/40-ide/plugins/10-completion/engine/coc/files/scripts/install-extensions.sh -------------------

TERM=dumb vim "+echo 'installing COC extensions'" "+CocInstall -sync $(echo `cat deps/coc-extensions.txt`)" "+w ! tee >&2" "+qa!"

# src/plugins/50-fuzzy-tools/plugins/02-fzf/files/scripts/install-extensions.sh -------------------

# sometimes, if the system already has an old FZF package
# fzf#install will get called from there and not from the plugin
# and it won't install required fzf binary
# let's make sure it's installed
bundle/fzf/install --bin
