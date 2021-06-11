
" src/plugins/20-settings/plugins/keymap/files/autoload/my/keymap.vim -------------------

fu! s:split(s)
 return split(a:s, '\zs')
endfu

fu! s:list(x)
  return (3 == type(a:x)) ? a:x : s:split(a:x)
endfu

fu! s:set(map, path, val)
  let l:map = a:map
  let l:keys = s:list(a:path)

  for l:k in l:keys[0:-2]
    let l:map[l:k] = get(l:map, l:k, {})
    let l:map = l:map[l:k]
  endfor

  let l:map[l:keys[-1]] = a:val
endfu


fu! my#keymap#label(map, path, name)
  call s:set(a:map, a:path, a:name)
endfu

fu! my#keymap#group(map, path, name)
  call s:set(a:map, s:list(a:path) + ['name'], a:name)
endfu

fu! my#keymap#set(map, path, name)
  if '+' == a:name[0]
    call my#keymap#group(a:map, a:path, a:name)
  else
    call my#keymap#label(a:map, a:path, a:name)
  endif
endfu

let g:my#keymap#leader#map = get(g:, 'my#keymap#leader#map', {})
fu! my#keymap#leader(path, name)
  call my#keymap#set(g:my#keymap#leader#map, a:path, a:name)
endfu

let g:my#keymap#localleader#map = get(g:, 'my#keymap#localleader#map', {})
fu! my#keymap#localleader(path, name)
  call my#keymap#set(g:my#keymap#localleader#map, a:path, a:name)
endfu

fu! my#keymap#format(name)
  " remove <CR> at the end
  let l:name = substitute(a:name, '\c<cr>$', '', '')

  " remove leading :
  let l:name = substitute(l:name, '^:', '', '')

  " remove leading <c-u>
  let l:name = substitute(l:name, '^\c<c-u>', '', '')

  " remove <plug> at the beginning
  let l:name = substitute(l:name, '^\c<Plug>', '', '')

  " remove "folders", e.g. (Foo/Bar-Baz/Boom) -> Boom
  let l:name = substitute(l:name, '^(\(\w[0-9A-Za-z_-]*/\)*\(.*\))$', '\2', '')

  " remove parens (foo) -> foo
  let l:name = substitute(l:name, '^(\(.*\))$', '\1', '')

  " convert some characters to spaces
  let l:name = substitute(l:name, '[-_()]', ' ', 'g')

  return l:name
endfu
