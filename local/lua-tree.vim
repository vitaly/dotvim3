Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" let g:lua_tree_side = 'right'

let g:lua_tree_bindings = {
      \ 'edit_split': ['s', 'i'],
      \ 'edit_vsplit': 'v',
      \ 'toggle_dotfiles': '.',
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

autocmd FileType LuaTree call s:lua_tree_settings()

function! s:lua_tree_settings() abort
  nnoremap <buffer> q :<C-U>LuaTreeToggle<CR>
  highlight LuaTreeFolderIcon guifg=yellow
endfunction


nnoremap  <silent>  <plug>(LuaTree/Toggle)      :<C-U>LuaTreeToggle<CR>
nmap                \]                          <plug>(LuaTree/Toggle)

nnoremap  <silent>  <plug>(LuaTree/Find-File)   :<C-U>LuaTreeFindFile<CR>
nmap                \0                          <plug>(LuaTree/Find-File)

