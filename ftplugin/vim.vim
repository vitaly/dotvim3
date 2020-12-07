
" src/plugins/70-languages/plugins/vimscript/files/ftplugin/vim.vim -------------------

call my#keymap#localleader('e', '+Eval')

noremap <buffer> <silent>        <plug>(Eval/Line)      yy:@"<CR>
nmap    <buffer> <localleader>ee <plug>(Eval/Line)

noremap <buffer>                 <plug>(Eval/File)    :so %<cr>
nmap    <buffer> <localleader>ef <plug>(Eval/File)

noremap <buffer>                 <plug>(Eval/Selection) y:@"<cr>
xmap    <buffer> <localleader>e  <plug>(Eval/Selection)
