ask string vim_python2 "python2 executable to use for pluginss" "$(command -v python2)"
ask string vim_pip2 "pip2 executable to install plugins ('-' to skip)" "$(command -v pip2)"

ask string vim_python3 "python3 executable to use for plugins" "$(command -v python3)"
ask string vim_pip3 "pip3 executable to install plugins ('-' to skip)" "$(command -v pip3)"

ask string vim_gem "ruby gems executable to install plugins ('-' to skip)" "$(command -v gem)"

ask string vim_yarn "yarn executable to install plugins ('-' to skip)" "$(command -v yarn)"

source "$(this_dir)/files/deps/install.sh"

ask string vim_ruby_host "neovim-ruby-host executable" "$(command -v  neovim-ruby-host)"

ask string vim_node_host "neovim-node-host executable" "$(command -v  neovim-node-host)"

{
  vim_banner "$(this_file)"

  if [ '-' != "$vim_python2" ]; then
    [ -x "$vim_python2" ] || warn "WARNING: python2 not found at $vim_python2" >&2
    echo "let g:python_host_prog='$vim_python2'"
  fi
  if [ '-' != "$vim_python3" ]; then
    [ -x "$vim_python3" ] || warn "WARNING: python3 not found at $vim_python3" >&2
    echo "let g:python3_host_prog='$vim_python3'"
  fi

  if [ '-' != "$vim_ruby_host" ]; then
    [ -x "$vim_ruby_host" ] || warn "WARNING: ruby not found at $vim_ruby_host" >&2
    echo "let g:ruby_host_prog='$vim_ruby_host'"
  fi

  if [ '-' != "$vim_node_host" ]; then
    [ -x "$vim_node_host" ] || warn "WARNING: node not found at $vim_node_host" >&2
    echo "let g:node_host_prog='$vim_node_host'"
  fi

} >> "${VIM_DIR}/vimrc"
