#!/bin/bash -eE
set -o pipefail

if [[ "-v" == "$1"  ]]; then
  shift
  VERBOSE=1
fi
ASK_VERBOSE="$VERBOSE"

source vendor/ask.sh/lib/ask.sh

non_standard_dir() {
  [ ! -d ~/.vim ] || [ "$VIM_DIR" != "$(cd ~/.vim; pwd -P)" ]
}

non_standard_dir_warning() {
  desc <<END
Your installation directory is $VIM_DIR
     Make sure you link:
       ~/.vim -> "$VIM_DIR"
     Depending on your version of vim you might also need to link:
       ~/.vimrc -> "$VIM_DIR/vimrc"

> Note: you can override the default directory by passing VIM_DIR to make: 'VIM_DIR=... make'
END
  ask bool vimdir_warning "I understand" y
}

clean_manifest() {
  if [ -f "${MANIFEST}" ]; then
    cat ${MANIFEST} | ( cd "${VIM_DIR}" && xargs rm -f )
  fi
  rm -f "${MANIFEST}"
  (set -x; touch "${MANIFEST}")
}

init_vimdir() {
  [ -n "$VIM_DIR" ] || die "please define VIM_DIR"

  mkdir -pv "$VIM_DIR"

  VIM_DIR="$(cd "$VIM_DIR"; pwd)"

  init ${VIM_DIR}/.config

  if non_standard_dir; then
    non_standard_dir_warning
  fi

  clean_manifest
}

MANIFEST="${VIM_DIR}/.files"

init_vimdir

source lib/common.sh

load_all plugins/*

finish
cat ${VIM_DIR}/.config  | grep '^[^#]' | sed -E -e "s/^([^=]+)=(.*)$/let g:dotvim#\1 = '\2'/" > ${VIM_DIR}/.dotvim.vim

bold
info -e "\nDONE: $VIM_DIR"
