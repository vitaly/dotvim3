function install_plug() {
  local plug_file=autoload/plug.vim
  [ -f "$plug_file" ]  && return
  echo installing plug
  curl -fLo autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

touch ~/.vim/.env.vim

install_plug
