ask string vim_gem "ruby gems executable to install plugins (leave empty to skip)" "$(command -v gem)"

ask string vim_python2 "python2 executable to use for pluginss" "$(command -v python2)"
ask string vim_pip2 "pip2 executable to install plugins (leave empty to skip)" "$(command -v pip2)"

ask string vim_python3 "python3 executable to use for plugins" "$(command -v python3)"
ask string vim_pip3 "pip3 executable to install plugins (leave empty to skip)" "$(command -v pip3)"

ask string vim_yarn "yarn executable to install plugins (leave empty to skip)" "$(command -v yarn)"

{
  vim_banner "$(this_file)"
  echo "let g:python_host_prog='$vim_python2'"
  echo "let g:python3_host_prog='$vim_python3'"
} >> "${VIM_DIR}/vimrc"
