desc "Statusline provider"

enum none      'not recommended ;)'
enum airline   "(DEPRECATED) I haven't used it for a while."
enum lightline 'lightline is uptodate.'

ask enum statusline "which status line plugin to install?" 1

if [ "1" != "$statusline" ]; then
  load "$(this_dir)/$statusline"
fi
