desc "Code Autoformatting"

enum neoformat "     - Neoformat"
enum vim-autoformat "- vim-autoformat"
enum - "             - none"

ask enum autoformat "autoformat plugin?" 1

[[ - = ${autoformat} ]] || copy_files "$(this_dir)/${autoformat}"
