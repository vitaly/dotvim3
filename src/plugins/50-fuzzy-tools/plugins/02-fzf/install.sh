if [ -z "$FZF_DEFAULT_COMMAND" -a -n "`which ag`" ]; then
  yellow
  cat <<END

***********************************************************************

Consider setting FZF_DEFAULT_COMMAND environment variable:

  export FZF_DEFAULT_COMMAND="ag --follow --nocolor --nogroup -g ''"

***********************************************************************

END
  nc
fi
