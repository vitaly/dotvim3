desc "What plugin to use for fuzzy buffer switching?:"

is_true unite_vim && enum unite '- use ":Unite buffer"'|| true
is_true ctrl_p    && enum ctrlp '- use ":CtrlPBuff"' || true
is_true use_fzf   && enum fzf '  - use FZF ":Buffers"' || true

desc_add "\nNote: this only affect which of the options will be bound to '<leader>bb'"
ask enum fuzzy_buffers "buffer search with?" 1

copy_files "$(this_dir)/$fuzzy_buffers"
