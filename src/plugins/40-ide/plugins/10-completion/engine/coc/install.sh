desc 'what version of COC.NVIM to install:'

enum release '- latest official release'
enum edge '   - build from latest master branch '

ask enum coc_version 'COC version?' 1
copy_files "$(this_dir)/versions/${coc_version}"

# linking the coc-settings.json becase it's a pain to always update it in 2 places
rm -f coc-settings.json
ln -sfn "$(this_dir)/coc-settings.json"
