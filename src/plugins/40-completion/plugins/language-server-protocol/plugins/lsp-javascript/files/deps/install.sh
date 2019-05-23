if [ '-' != "$vim_yarn" ]; then
  if ! command -v javascript-typescript-stdio > /dev/null; then
    (set -x; $vim_yarn global add javascript-typescript-langserver)
  fi
  if ! command -v typescript-language-server > /dev/null; then
    (set -x; $vim_yarn global add typescript-language-server)
  fi
fi
