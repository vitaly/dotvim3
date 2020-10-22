desc <<END
allow toggling of "clipboard" setting in vim, allowing sharing of
clipboard content b/w  vim and OS

initial clipboard is in an 'internal' mode (e.g. not shared)

see bindings.

Note: if you chose "splus" and it doesn't seem to work, try "star"
END

# ask_bool system_clipboard '"merge" vim and system clipboards?'
# false

enum off '      - disable clipboard toggle'
enum star '     - yank uses register * (clipboard=unnamed)'
enum plus '     - yank uses register + (clipboard=unnamed plus)'
ask enum clipboard "Which clipboard mode should be used fror toggling" star

if test "off" != "$clipboard"; then
  ask bool clipboard_shared "Should clipboard start in shared mode?" y
  true
else
  false
fi
