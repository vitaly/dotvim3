
" local/files/ftplugin/ruby.vim -------------------

" AutoFormat

call my#keymap#leader('fer', '+Rails')

nnoremap                               <plug>(File/Edit/Rails/Application)        :e config/application.rb<cr>
nmap      <buffer>   <leader>fera      <plug>(File/Edit/Rails/Application)

nnoremap                               <plug>(File/Edit/Rails/Environment)        :e config/application.rb<cr>
nmap      <buffer>   <leader>fere      <plug>(File/Edit/Rails/Environment)

nnoremap                               <plug>(File/Edit/Rails/Development)        :e config/environments/development.rb<cr>
nmap      <buffer>   <leader>ferd      <plug>(File/Edit/Rails/Development)

nnoremap                               <plug>(File/Edit/Rails/Production)         :e config/environments/production.rb<cr>
nmap      <buffer>   <leader>ferp      <plug>(File/Edit/Rails/Production)

nnoremap                               <plug>(File/Edit/Rails/Test)               :e config/environments/test.rb<cr>
nmap      <buffer>   <leader>fert      <plug>(File/Edit/Rails/Test)
