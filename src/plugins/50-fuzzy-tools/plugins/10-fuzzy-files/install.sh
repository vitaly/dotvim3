is_true use_fzf   && enum fzf "  - use ':Files' from FZF" || true
is_true unite_vim && enum unite "- use ':Unite file_rec/async:!'" || true
is_true ctrl_p    && enum ctrlp "- use ':CtrlP'" || true

desc <<END
What plugin to use for fuzzy file search?:

Note: this only affect which of the options will be bound to '<leader>ff'
END
ask enum fuzzy_files "files search with?" 1

copy_files "$(this_dir)/$fuzzy_files"
copy_files "$(this_dir)/common"
