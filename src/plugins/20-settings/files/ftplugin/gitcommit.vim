setlocal textwidth=72
setlocal spell

" au BufEnter <buffer> startinsert

" disable restoring of cursor position for commit messages
" always start at the top
augroup RestoreLastFilePosition | au! | augroup END
