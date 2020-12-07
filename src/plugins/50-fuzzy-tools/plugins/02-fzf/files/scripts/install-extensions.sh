# sometimes, if the system already has an old FZF package
# fzf#install will get called from there and not from the plugin
# and it won't install required fzf binary
# let's make sure it's installed
bundle/fzf/install --bin
