enum which_key "    - use which-key"
enum leader_guide " - use leader-guide"

desc <<END
Which plugin to use for keymap menus?
END

ask enum keymap_engine "keymap engine?" 1

load "$(this_dir)/engine/$keymap_engine"
