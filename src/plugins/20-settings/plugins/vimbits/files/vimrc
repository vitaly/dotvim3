" go to last position in a file when opening it
augroup RestoreLastFilePosition
  au!
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
