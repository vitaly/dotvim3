verbose() {
  if [ -n "$VERBOSE" ]; then
    true
  else
    false
  fi
}

v() {
  if verbose; then
    "$@"
  fi
}

clean_path() {
  realpath --relative-base . "$1"
}


this_file() {
  clean_path "${BASH_SOURCE[1]}"
}

this_dir() {
  clean_path "$(dirname "${BASH_SOURCE[1]}")"
}

ruby_banner() {
      echo
      echo "# $1 -------------------"
      echo
  }


vim_banner() {
    echo
    echo "\" $1 -------------------"
    echo
}

# banner FILE LABEL
# 'FILE' is used to determin type of banner
banner() {
  local file=$(clean_path "$1")

  case "$file" in
    *.md) ;;
    *.rb|*.sh|*.gitignore) ruby_banner "$1";;
    *vimrc|*vimrc.*|*.vim) vim_banner "$1";;
    *) ;;
  esac
}

append_to_file() {
  local base="$1"
  local file="$2"

  local src="$base/$file"
  local dst=$file

  mkdir -pv "$(dirname "$dst")"

  if ! grep -Fxq "$file" "$MANIFEST"; then
    # first time writing into this file during this run
    rm -f "$dst"
    touch "$dst"
    echo "$file" >> "$MANIFEST"
    local empty=1
  else
    local empty=
  fi

  v cyan "-- $file -> $dst"

  if [ ! -x "$src" -o -z "$empty"  ]; then
    banner $(realpath --relative-base . "$src") >> "$dst"
  fi

  cat "$src" >> "$dst"
}

# copy files from directory into target
# will fail if directory doesn't exist
copy_files() {
  local base="$1"

  [[ -d $1 ]] || die "directory '$1' not found"

  v blue $base

  for f in $(cd "$base" && find . -type f); do
    f=${f#./}

    append_to_file "$base" "$f"
  done
}

# there are 2 kinds of plugins:
# 1 - simple. only have files to copy
# and 2 - complex, have more 'structure', or scripts to run
complex() {
  [[ -e "$1/prompt.sh" || -e "$1/install.sh" || -d "$1/plugins" || -d "$1/files" ]]
}

load() {
  v yellow "$1"

  [[ -d $1 ]] || die "'$1' not found"

  if ! complex "$1"; then
    copy_files "$1"
    return
  fi

  if [ -f "$1/prompt.sh" ]; then
    local prompt=""

    # we are runnign with -eE here
    # can't just eval or failure in the code
    # will trip the ERR trap
    # so we compile it into a func
    # this way our `if` will prevent ERR trap
    eval "should_install_plugin() { $(cat "$1/prompt.sh"); }"
    should_install_plugin || return 0
  fi

  if [[ -d $1/files ]]; then copy_files "$1/files"; fi
  if [[ -d $1/plugins ]]; then load_all "$1/plugins/"*; fi
  if [[ -f $1/install.sh ]]; then source "$1/install.sh"; fi
}

load_all() {
  for d in "$@"; do
    load "$d"
  done
}
