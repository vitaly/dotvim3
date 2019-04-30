
" src/plugins/60-development/plugins/neoformat/files/ftplugin/javascript.vim -------------------

set sw=2
augroup TsNeoformatOnSave
  au! * <buffer>
  :AutoFormat
augroup END
