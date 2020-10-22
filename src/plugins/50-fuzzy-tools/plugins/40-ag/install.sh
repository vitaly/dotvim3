desc  <<END
Search using AG - The Silver Searcher
https://github.com/ggreer/the_silver_searcher
END

is_true use_fzf  && \
  enum fzf '     - use ":Ag" from FZF' || true
true && \
  enum vim-ag '  - use ":Ag" from vim-ag plugin'

ask enum ag "Which AG to use?" 1

copy_files "$(this_dir)/$ag"
