
" src/plugins/10-init/files/vimrc -------------------

scriptencoding utf8

" this file mirrors all the variavles from .conf
runtime .config.vim

" this  can be used to setup environment.
" e.g node/ruby/python providers etc
runtime .env.vim

" src/plugins/20-settings/files/vimrc -------------------

if ! has('nvim')
  set nocompatible
endif

syntax on

" prevent vim from adding that stupid empty line at the end of every file
set noeol
set binary

" utf-8/unicode support
" requires Vim to be compiled with Multibyte support, you can check that by
" running `vim --version` and checking for +multi_byte.
if has('multi_byte')
  scriptencoding utf-8
  set encoding=utf-8
end

" presentation settings
set number              " precede each line with its line number
set numberwidth=3       " number of culumns for line numbers
set textwidth=0         " Do not wrap words (insert)
set nowrap              " Do not wrap words (view)
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set visualbell          " use visual bell instead of beeping
set listchars=tab:→⋅,trail:·,nbsp:+
set list

" highlight spell errors
hi SpellErrors guibg=red guifg=black ctermbg=red ctermfg=black

" behavior
                        " ignore these files when completing names and in
                        " explorer
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif
set shell=/bin/bash     " use bash for shell commands
set autowriteall        " Automatically save before commands like :next and :make
set hidden              " enable multiple modified buffers
set guioptions-=T       " disable toolbar"
set completeopt=menuone,preview,noinsert
let bash_is_sh=1        " syntax shell files as bash scripts
set cinoptions=:0,(s,u0,U1,g0,t0 " some indentation options ':h cinoptions' for details
set modelines=5         " number of lines to check for vim: directives at the start/end of file
"set fixdel                 " fix terminal code for delete (if delete is broken but backspace works)

set ts=4                " number of spaces in a tab
set sw=4                " number of spaces for indent
set et                  " expand tabs into spaces

set ttimeoutlen=50      " fast Esc to normal mode
set updatetime=300

let g:mapleader = " "
let g:maplocalleader = ","
set timeoutlen=5000     " give 5s to complete mapping sequence

" mouse settings
if has("mouse")
  set mouse=a
endif
set mousehide                           " Hide mouse pointer on insert mode."

" search settings
set hlsearch            " Highlight search match
set ignorecase          " Do case insensitive matching
set smartcase           " do not ignore if search pattern has CAPS

" directory settings
call system('mkdir -vp ~/.backup/undo/ > /dev/null 2>&1')
set backupdir=~/.backup,.       " list of directories for the backup file
set directory=~/.backup,~/tmp,. " list of directory names for the swap file
set nobackup            " do not write backup files
set backupskip+=~/tmp/*,/private/tmp/* " skip backups on OSX temp dir, for crontab -e to properly work
set noswapfile          " do not write .swp files
set undodir=~/.backup/undo/,~/tmp,.
set undofile

" folding
set foldcolumn=0        " columns for folding
set foldmethod=syntax
set foldlevel=9
set nofoldenable        " dont fold by default "

" concealing
set concealcursor=n
set conceallevel=2

" Don't use Ex mode, use Q for formatting
map Q gq

" driving me insane this thing
command Q q
command Qa qa
command QA qa
command -nargs=* -complete=file W w <args>
command -nargs=* -complete=file E e <args>

call plug#begin('~/.vim/bundle')

source ~/.vim/vimrc.plugins

call plug#end()

" src/plugins/20-settings/plugins/indent-level-navigation/files/vimrc -------------------

" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>^
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>^
xnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>^m'gv''

nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>^
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>^
xnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>^^m'gv''m'gv''

nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>^
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>^
xnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>^m'gv''

nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>^
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>^
xnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>^m'gv''


" src/plugins/20-settings/plugins/interpreters/files/vimrc -------------------

let $PYTHONWARNINGS="ignore:DEPRECATION"

" src/plugins/20-settings/plugins/termguicolors/files/vimrc -------------------

if has('termguicolors')
  set termguicolors
end

" src/plugins/99-final/plugins/10-local-configs/files/vimrc -------------------

source ~/.vim/local/vimrc

" local/vimrc -------------------

scriptencoding utf8

" src/plugins/99-final/plugins/98-exrc/files/vimrc -------------------

" autoload local project .vimrc files
set exrc

" src/plugins/99-final/plugins/99-secure/files/vimrc -------------------

" prevent .vimrc files from issuing unsecure commands
set secure
