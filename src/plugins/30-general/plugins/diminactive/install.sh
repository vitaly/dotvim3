desc << END
The dimning can be done with colorcolunbs (it changes background of inactive
splits), or with switching the syntax highlighting off for inactive splits.
END

enum off '        - disable diminactive '
enum syntax '     - dim by disabling syntax highlighting'
enum colors '     - dim by changing background'

ask enum dim_mode "Which dimming mode to set?"

copy_files "$(this_dir)/mode/$dim_mode"
