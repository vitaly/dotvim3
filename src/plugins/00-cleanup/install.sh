
(
cd "$VIM_DIR"

# remove old version leftovers
OLD_FILES="$(cat src/plugins/00-cleanup/lists/old-files)"
rm -fv $OLD_FILES

MANAGED_DIRS="$(cat src/plugins/00-cleanup/lists/managed-dirs)"
mkdir -p $MANAGED_DIRS

# managed files. plrepare empty placeholders to be modified later during the install
MANAGED_FILES="$(cat src/plugins/00-cleanup/lists/managed-files)"
rm -f $MANAGED_FILES
touch $MANAGED_FILES

# local customization files. make sure they exist, but do not manage their content
LOCAL_FILES="$(cat src/plugins/00-cleanup/lists/local-files)"
touch $LOCAL_FILES
)
