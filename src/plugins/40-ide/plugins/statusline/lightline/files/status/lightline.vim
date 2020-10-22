scriptencoding utf8

let g:lightline = {}
let g:lightline.active = {}
let g:lightline.inactive = {}
let g:lightline.component = {}
let g:lightline.component_function = {}
let g:lightline.component_expand = {}
let g:lightline.component_type = {}
let g:lightline.component_visible_condition = {}

" HEX
let g:lightline.component.hex  = '%02B'

" RO
fun! status#lightline#ro()
 return "%{(&readonly || !&modifiable) ? '' : ''}"
endf
let g:lightline.component_expand.ro  = 'status#lightline#ro'
let g:lightline.component_type.ro = 'error'

" COC_GIT
fun! status#lightline#coc_git()
  return get(g:,'coc_git_status','')
endf
let g:lightline.component_function.coc_git = 'status#lightline#coc_git'

" FUGITIVE
fun! status#lightline#fugitive()
  let branch = fugitive#head()
  return branch !=# '' ? '⭠ ' . branch : ''
endf
let g:lightline.component_function.fugitive = 'status#lightline#fugitive'

" FULL COC STATUS
fun! status#lightline#full_coc_status()
  return coc#status()
endf
let g:lightline.component_function.full_coc_status = 'status#lightline#full_coc_status'

" COC STATUS
fun! status#lightline#coc_status()
  return get(g:, 'coc_status', '')
let g:lightline.component_function.coc_status = 'status#lightline#coc_status'
endf

" COC DIAGNOSTIC
fun! status#lightline#coc_diagnostic(kind, symbol) abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, a:kind, 0)
    return info[a:kind] . a:symbol
  else
    return ""
  endif
endf

fun! status#lightline#coc_errors() abort
  return status#lightline#coc_diagnostic('error', '✗')
endf
let g:lightline.component_expand.coc_errors  = 'status#lightline#coc_errors'
let g:lightline.component_type.coc_errors = 'error'

fun! status#lightline#coc_warnings() abort
  return status#lightline#coc_diagnostic('hint', '') . " " .
        \ status#lightline#coc_diagnostic('information', 'i') . " " .
        \ status#lightline#coc_diagnostic('warning', '!')
endf
let g:lightline.component_expand.coc_warnings  = 'status#lightline#coc_warnings'

" GUTENTAGS
fun! status#lightline#tags_cb(mods) abort
  return "[tags]"
endf
fun! status#lightline#gutentags()
  return "%{gutentags#statusline_cb(function('status#lightline#tags_cb'))}"
endf
let g:lightline.component_expand.gutentags = 'status#lightline#gutentags'
let g:lightline.component_type.gutentags   = 'error'

" ALE
let g:ale_sign_error = "✗"
let g:ale_sign_warning = "!"
let g:ale_sign_info = "i"
let g:ale_sign_style_error = ""
let g:ale_sign_style_warning = ""
let g:lightline#ale#indicator_checking = '...'
let g:lightline#ale#indicator_errors = ''
let g:lightline#ale#indicator_warnings = ''
let g:lightline#ale#indicator_ok = '✓'

let g:lightline.component_expand.ale_checking = 'lightline#ale#checking'
let g:lightline.component_type.ale_checking   = 'left'

let g:lightline.component_expand.ale_errors   = 'lightline#ale#errors'
let g:lightline.component_type.ale_errors     = 'error'

let g:lightline.component_expand.ale_warnings = 'lightline#ale#warnings'
let g:lightline.component_type.ale_warnings   = 'warning'

let g:lightline.component_expand.ale_ok       = 'lightline#ale#ok'
let g:lightline.component_type.ale_ok         = 'left'


let g:lightline.active.left  = [ [ 'mode', 'paste' ], ['fugitive'], [ 'ro', 'filename', 'modified', 'gutentags' ] ]
let g:lightline.active.right = [ [ 'hex', 'lineinfo' ], ['filetype'], ['fileformat', 'fileencoding'] ]

if get(g:, 'dotvim#completion_engine', '') == 'coc'
  let g:lightline.active.right += [[ 'coc_status', 'ale_checking', 'ale_errors', 'ale_warnings', 'ale_ok' ]]
else
  let g:lightline.active.right += [[ 'ale_checking', 'ale_errors', 'ale_warnings', 'ale_ok' ]]
endif


let g:lightline.inactive.left  = [ [ 'filename' ] ]
let g:lightline.inactive.right = [ ]

fun! LightlineColorscheme(name)
  let g:lightline.colorscheme = a:name
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endf

" TBD: FIXME: TODO: cleanup!
"
" let g:lightline.colorscheme = 'wombat'
" let g:lightline.colorscheme = 'solarized'
" let g:lightline.colorscheme = 'powerline'
" let g:lightline.colorscheme = 'jellybeans'
let g:lightline.colorscheme = 'Tomorrow'
" let g:lightline.colorscheme = 'Tomorrow_Night'
" let g:lightline.colorscheme = 'Tomorrow_Night_Blue'
" let g:lightline.colorscheme = 'Tomorrow_Night_Eighties'
" let g:lightline.colorscheme = 'PaperColor'
" let g:lightline.colorscheme = 'seoul256'
" let g:lightline.colorscheme = 'landscape'
" let g:lightline.colorscheme = 'one'
" let g:lightline.colorscheme = 'darcula'
" let g:lightline.colorscheme = 'molokai'
" let g:lightline.colorscheme = 'materia'
" let g:lightline.colorscheme = 'material'
" let g:lightline.colorscheme = 'OldHope'
" let g:lightline.colorscheme = 'nord'
" let g:lightline.colorscheme = '16color'
" let g:lightline.colorscheme = 'deus'


augroup AuStatusLightline
  au!
  au User CocDiagnosticChange call lightline#update()
  au User GutentagsUpdating   call lightline#update()
  au User GutentagsUpdated    call lightline#update()
augroup END
