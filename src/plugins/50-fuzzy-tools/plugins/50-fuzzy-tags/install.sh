desc "Tag search"

is_true use_fzf   && enum fzf '  - use ":Tags" from FZF' || true
is_true unite_vim && enum unite '- use ":Unite tags"' || true
is_true ctrl_p    && enum ctrlp '- use ":CtrlPTags"' || true

ask enum fuzzy_tags "tags search with?" 1

copy_files "$(this_dir)/$fuzzy_tags"
