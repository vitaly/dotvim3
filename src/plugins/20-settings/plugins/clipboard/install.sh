{
  vim_banner "$(this_file)"


  case $clipboard in
    star) echo "let g:clipboard_toggle_mode='unnamed'";;
    plus) echo "let g:clipboard_toggle_mode='unnamedplus'";;
    *)    echo "invalid clipboard mode"; exit 1;;
  esac

  if is_true clipboard_shared; then
    echo "let &clipboard=g:clipboard_toggle_mode"
  fi

} >> vimrc.bindings
