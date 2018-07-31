(
cd "$VIM_DIR"

# remove old version leftovers
OLD_FILES="
vimrc.before gvimrc.before
gvimrc.bindings
filetype.vim
README.index.md README.content.md
"
rm -fv $OLD_FILES

MANAGED_DIRS="after/plugin ftplugin colors"
mkdir -pv $MANAGED_DIRS

MANAGED_FILES="
README.md
.gitignore
vimrc vimrc.plugins vimrc.after
vimrc.bindings
gvimrc.plugins gvimrc.after
after/plugin/after.vim
colors/buttercream.vim colors/colorzone.vim
ftplugin/gitcommit.vim ftplugin/javascript.vim ftplugin/vim.vim ftplugin/vimwiki.vim
"

# prepare empty placeholders for managed files
rm -f $MANAGED_FILES
touch $MANAGED_FILES
)
