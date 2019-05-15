
" src/plugins/70-languages/plugins/vimscript/files/ftplugin/vim.vim -------------------

" [E]val [L]ine
noremap <buffer>                 <plug>(Eval/Line)      yy:@"<CR>
nmap    <buffer> <localleader>ee <plug>(Eval/Line)

noremap <buffer>                 <plug>(Eval/Buffer)    :so %<cr>
nmap    <buffer> <localleader>eb <plug>(Eval/Buffer)

noremap <buffer>                 <plug>(Eval/Selection) y:@"<cr>
vmap    <buffer> <localleader>es <plug>(Eval/Selection)
