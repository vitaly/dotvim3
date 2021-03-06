
" src/plugins/10-init/files/after/plugin/after.vim -------------------

scriptencoding utf8

" after/plugin/after.vim can get called multiple times when new bundles are
" installed. we want to only call our scripts once
if (exists("g:after_vim_loaded") && g:after_vim_loaded)
  finish
endif
let g:after_vim_loaded = 1


if $VIMRC_SKIP_AFTER_CONFIGS == ''
  source ~/.vim/vimrc.bindings
  source ~/.vim/vimrc.after
endif
