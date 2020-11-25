# linking the coc-settings.json vecase it's a pain to always update it in 2 places
rm -f coc-settings.json
ln -sfn "$(this_dir)/coc-settings.json"
