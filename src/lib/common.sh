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


this_file() {
  echo "${BASH_SOURCE[1]}"
}

this_dir() {
  dirname "${BASH_SOURCE[1]}"
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
  local file="$1"

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
  local dst="${VIM_DIR}/${file}"

  mkdir -pv "$(dirname "$dst")"

  if ! grep -Fxq "$file" "${MANIFEST}"; then
    # first time writing into this file during this run
    rm -f "$dst"
    touch "$dst"
    echo "$file" >> "${MANIFEST}"
    local empty=1
  else
    local empty=
  fi

  v cyan "-- $file -> $dst"

  if [ ! -x "$src" -o -z "$empty"  ]; then
    banner "src/$src" >> "$dst"
  fi

  cat "$src" >> "$dst"
}

# copy files from directory into target
# will fail if directory doesn't exist
copy_files() {
  local base="$1"
  [ -d "$base" ] || die "directory $base not found"

  _copy_files "$@"
}

# copy files from directory into target
# will ignore if directory doesn't exist
_copy_files() {
  local base="$1"

  if [ ! -d "$base" ]; then
    return
  fi

  v blue $base

  for f in $(cd "$base" && find . -type f); do
    f="${f#./}"

    append_to_file "$base" "$f"
  done
}

load() {
  v yellow "$1"

  [ -e "$1" ] || die "'$1' not found"

  if [ -f "$1/prompt.sh" ]; then
    if ! eval "$(cat "$1/prompt.sh")"; then
      return
    fi
  fi

  if [ -d "$1/files" ]; then copy_files "$1/files"; fi
  if [ -d "$1/plugins" ]; then load_all "$1/plugins/"*; fi
  if [ -f "$1/install.sh" ]; then source "$1/install.sh"; fi
}

load_all() {
  for d in "$@"; do
    load "$d"
  done
}
