aug set_typescript_repl
  au!
  au FileType typescript
        \ if executable('node_modules/.bin/ts-node')            |
        \   call neoterm#repl#set('node_modules/.bin/ts-node')  |
        \ elseif executable('ts-node')                          |
        \   call neoterm#repl#set('ts-node')                    |
        \ endif
augroup END
