
" src/plugins/70-languages/plugins/vimscript/files/ftplugin/vim.vim -------------------

" [E]val [L]ine
nnoremap <buffer>                 <plug>eval(line)   yy:@"<CR>
nmap     <buffer> <localleader>ee <plug>eval(line)

nnoremap <buffer>                 <plug>eval(buffer) :so %<cr>
nmap     <buffer> <localleader>eb <plug>eval(buffer)
