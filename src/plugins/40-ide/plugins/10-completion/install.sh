enum deoplete "- use Deoplete"
enum coc "     - use COC"
enum none "    - None"

desc <<END
What completion plugin to use?
END

ask enum completion_engine "completion engine?" 1

if [ 'none' != "$completion_engine" ]; then
  load "$(this_dir)/engine/$completion_engine"
fi
