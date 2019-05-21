if [ '-' != "$vim_yarn" ]; then
  if ! command -v javascript-typescript-stdio > /dev/null; then
    (set -x; $vim_yarn global add javascript-typescript-langserver)
  fi
fi
