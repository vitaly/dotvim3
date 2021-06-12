Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" let g:lua_tree_side = 'right'

let g:lua_tree_bindings = {
      \ 'edit_split': ['s', 'i'],
      \ 'edit_vsplit': 'v',
      \ 'toggle_dotfiles': '.',
      \ 'cut': 'm',
      \ 'edit': '<CR>',
      \ 'cd': ['<C-]>', 'o'],
      \ }

let g:lua_tree_follow = 1
let g:lua_tree_indent_markers = 1
let g:lua_tree_git_hl = 1

highlight LuaTreeFolderIcon guifg=yellow

let g:lua_tree_icons = {
      \ 'default': '',
      \ 'symlink': '',
      \ 'git': {
      \   'unstaged': "",
      \   'staged': "✓",
      \   'unmerged': "",
      \   'renamed': "➜",
      \   'untracked': "?",
      \   'deleted': "✗"
      \   },
      \ 'folder': {
      \   'default': "",
      \   'open': "",
      \   'symlink': "",
      \   }
      \ }

function! s:toggleZoom()
  if exists('b:LuaTreeZoomed') && b:LuaTreeZoomed
    exec "silent vertical resize " . get(g:, 'lua_tree_width', 30)
    let b:LuaTreeZoomed = 0
  else
    exec 'vertical resize '. get(g:, 'lua_tree_width_max', '')
    let b:LuaTreeZoomed = 1
  endif
endfunction

autocmd FileType LuaTree call s:lua_tree_settings()

function! s:lua_tree_settings() abort

  nnoremap <buffer>     q       :LuaTreeClose<CR>
  nnoremap <buffer>     A       :call <SID>toggleZoom()<CR>

  highlight LuaTreeFolderIcon guifg=yellow
endfunction


nnoremap  <silent>  <plug>(LuaTree/Toggle)      :LuaTreeToggle<CR>
nmap                \]                          <plug>(LuaTree/Toggle)

nnoremap  <silent>  <plug>(LuaTree/Find-File)   :LuaTreeFindFile<CR>
nmap                \0                          <plug>(LuaTree/Find-File)


let g:lua_tree_width_allow_resize = 0
let g:lua_tree_width_max = 80
