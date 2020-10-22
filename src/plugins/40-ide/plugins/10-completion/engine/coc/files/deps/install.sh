# coc extensions
TERM=dumb vim "+echo 'installing COC extensions'" "+CocInstall -sync $(echo `cat deps/coc-extensions.txt`)" "+w ! tee >&2" "+qa!"
