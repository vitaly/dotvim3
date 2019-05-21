enum deoplete "use Deoplete"

desc <<END
What completion plugin to use?
END

ask enum completion_engine "completion engine?" 1

load "$(this_dir)/engine/$completion_engine"
