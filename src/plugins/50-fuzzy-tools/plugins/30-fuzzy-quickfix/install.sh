desc "Search for an entry in the current quickfix errors and jump to it."
desc_add "We can use several plugins for it:"

if is_true unite_vim; then
  enum unite "- use ':Unite quickfix'"
  desc_add "Note: 'osyo-manga/unite-quickfix' plugin will be installed if you choose 'unite' option."
fi

if is_true ctrl_p; then
  enum ctrlp "- use ':CtrlPQuickfix'"
fi

if is_true use_fzf; then
  enum fzf   "- use <Plug>fzf(quickfix)"
fi

ask enum fuzzy_quickfix "quickfix search with?" 1

copy_files "$(this_dir)/$fuzzy_quickfix"
