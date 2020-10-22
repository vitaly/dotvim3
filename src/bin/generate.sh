#!/bin/bash -eE
set -o pipefail

if [[ "-v" == "$1"  ]]; then
  shift
  VERBOSE=1
fi
ASK_VERBOSE="$VERBOSE"

source vendor/ask.sh/lib/ask.sh

: ${VIM_DIR:=$(pwd -P)}

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

  clean_manifest
}

MANIFEST="${VIM_DIR}/.files"

init_vimdir

source lib/common.sh

load_all plugins/*

finish
cat ${VIM_DIR}/.config  | grep '^[^#]' | sed -E -e "s/^([^=]+)=(.*)$/let g:dotvim#\1 = '\2'/" > ${VIM_DIR}/.config.vim

bold
info -e "\nDONE: $VIM_DIR"
