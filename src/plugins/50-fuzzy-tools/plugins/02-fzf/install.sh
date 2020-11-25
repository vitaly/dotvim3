if [[ -z "${FZF_DEFAULT_COMMAND:-}" ]]; then
  if [[ -n $(command -v rg) ]]; then
    FZF_SUGGEST="export FZF_DEFAULT_COMMAND=\"rg --files --hidden --follow -g '!{.git,node_modules}/*' 2> /dev/null\""
  elif [[ -n $(command -v ag) ]]; then
    FZF_SUGGEST="export FZF_DEFAULT_COMMAND=\"ag --follow --nocolor --nogroup -g ''\""
  fi

  if [[ $FZF_SUGGEST ]]; then
  yellow
  cat <<END

***********************************************************************

Consider setting FZF_DEFAULT_COMMAND environment variable:

  $FZF_SUGGEST

***********************************************************************

END
    nc
  fi
fi
