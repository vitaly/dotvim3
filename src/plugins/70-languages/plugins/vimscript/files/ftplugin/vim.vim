" [E]val [L]ine
noremap <buffer>                 <plug>eval(line)   yy:@"<CR>
nmap    <buffer> <localleader>ee <plug>eval(line)

noremap <buffer>                 <plug>eval(buffer) :so %<cr>
nmap    <buffer> <localleader>eb <plug>eval(buffer)
