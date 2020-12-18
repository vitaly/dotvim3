if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'

augroup DefXMappings
  au!
  autocmd FileType defx call s:defx_my_settings()
augroup end

function! s:defx_my_settings() abort
  set nonumber

  call defx#custom#column('icon', {
        \ 'directory_icon': '▸',
        \ 'opened_icon': '▾',
        \ 'root_icon': ' ',
        \ })
  call defx#custom#column('mark', {
        \ 'readonly_icon': '',
        \ 'selected_icon': '✓',
        \ })
  call defx#custom#column('git', 'indicators', {
        \ 'Modified'  : '',
        \ 'Staged'    : '✚',
        \ 'Untracked' : '?',
        \ 'Renamed'   : '➜',
        \ 'Unmerged'  : '',
        \ 'Ignored'   : 'i',
        \ 'Deleted'   : '✗',
        \ 'Unknown'   : '~'
        \ })

   let g:defx_icons_enable_syntax_highlight = 1
   " let g:defx_icons_column_length = 3
   let g:defx_icons_directory_icon = ''
   let g:defx_icons_mark_icon = '✓'
   let g:defx_icons_copy_icon = ''
   let g:defx_icons_move_icon = ''
   let g:defx_icons_parent_icon = ''
   let g:defx_icons_default_icon = ''
   let g:defx_icons_directory_symlink_icon = ''
   " Options below are applicable only when using "tree" feature
   let g:defx_icons_root_opened_tree_icon = ''
   let g:defx_icons_nested_opened_tree_icon = ''
   let g:defx_icons_nested_closed_tree_icon = ''


  nnoremap <silent><buffer><expr>   <CR>
        \ defx#is_directory() ?
        \ defx#do_action('open_tree', 'toggle') :
        \ defx#do_action('multi', ['quit', 'open'])

  nnoremap <silent><buffer><expr>   <2-LeftMouse>
        \ defx#is_directory() ?
        \ defx#do_action('open_tree', 'toggle') :
        \ defx#do_action('multi', ['quit', 'open'])

  " nnoremap <silent><buffer><expr> <CR>
  "       \ defx#do_action('multi', ['drop', 'quit'])

  nnoremap <silent><buffer><expr>   o
        \ defx#is_directory() ?
        \ defx#do_action('open') :
        \ defx#do_action('multi', ['quit', 'open'])

  nnoremap <silent><buffer><expr>   <C-]>
        \ defx#is_directory() ?
        \ defx#do_action('open') :
        \ defx#do_action('multi', ['quit', 'open'])

  nnoremap <silent><buffer><expr>   <tab>        defx#do_action('preview')

  nnoremap <silent><buffer><expr>   s            defx#do_action('multi', ['quit', ['open', 'bo split']])
  nnoremap <silent><buffer><expr>   i            defx#do_action('multi', ['quit', ['open', 'bo split']])


  nnoremap <silent><buffer><expr>   v            defx#do_action('multi', ['quit', ['open', 'bo vsplit']])

  nnoremap <silent><buffer><expr>   q            defx#do_action('quit')

  nnoremap <silent><buffer><expr>   u            defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr>   ~            defx#do_action('cd')

  nnoremap <silent><buffer><expr>   .            defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr>   I            defx#do_action('toggle_ignored_files')

  nnoremap <silent><buffer><expr>   <Space>      defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr>   *            defx#do_action('toggle_select_all')

  nnoremap <silent><buffer><expr>   d           defx#do_action('remove')
  nnoremap <silent><buffer><expr>   r           defx#do_action('rename')
  nnoremap <silent><buffer><expr>   m           defx#do_action('multi', ['move', 'redraw'])
  nnoremap <silent><buffer><expr>   c           defx#do_action('multi', ['copy', 'redraw'])
  nnoremap <silent><buffer><expr>   p           defx#do_action('paste')
  nnoremap <silent><buffer><expr>   a           defx#do_action('new_file')

  nnoremap <silent><buffer><expr>   C            defx#do_action('toggle_columns', 'mark:git:indent:icons:filename:type:size:time')
  nnoremap <silent><buffer><expr>   <C-l>        defx#do_action('redraw')

  nnoremap <silent><buffer><expr>   yy           defx#do_action('yank_path')

  " nnoremap <silent><buffer><expr>   ;            defx#do_action('repeat')

  " nnoremap <silent><buffer><expr>   A           defx#do_action('new_directory')
  " nnoremap <silent><buffer><expr>   l            defx#do_action('open')
  " nnoremap <silent><buffer><expr>   M            defx#do_action('new_multiple_files')
  " nnoremap <silent><buffer><expr>   S            defx#do_action('toggle_sort', 'time')
  " nnoremap <silent><buffer><expr>   !            defx#do_action('execute_command')
  " nnoremap <silent><buffer><expr>   x            defx#do_action('execute_system')
  " nnoremap <silent><buffer><expr>   j            line('.') == line('$') ? 'gg' : 'j'
  " nnoremap <silent><buffer><expr>   k            line('.') == 1 ? 'G' : 'k'
  " nnoremap <silent><buffer><expr>   <C-g>        defx#do_action('print')
  " nnoremap <silent><buffer><expr>   cd           defx#do_action('change_vim_cwd')
endfunction

nnoremap  <silent>    <plug>(Defx/Toggle)       :<c-u>Defx
      \ -split=vertical
      \ -direction=topleft
      \ -winwidth=30
      \ -toggle
      \ -columns=mark:git:indent:icons:filename<cr>

nmap                  <leader>.                 <plug>(Defx/Toggle)

nnoremap  <silent>    <plug>(Defx/Find-File)    :<c-u>Defx
      \ -split=vertical
      \ -direction=topleft
      \ -winwidth=30
      \ -search=<c-r>=expand('%:p')<cr>
      \ -columns=mark:git:indent:icons:filename<cr>

nmap                  <localleader>0            <plug>(Defx/Find-File)
