call my#keymap#localleader('e', '+Eval')

noremap <buffer> <silent>        <plug>(Eval/Line)      yy:@"<CR>
nmap    <buffer> <localleader>ee <plug>(Eval/Line)

noremap <buffer>                 <plug>(Eval/File)    :so %<cr>
nmap    <buffer> <localleader>ef <plug>(Eval/File)

noremap <buffer>                 <plug>(Eval/Selection) y:@"<cr>
vmap    <buffer> <localleader>es <plug>(Eval/Selection)
