if [ '-' != "$vim_gem" ]; then
  if ! command -v solargraph > /dev/null; then
    (set -x; $vim_gem install solargraph)
  fi
fi
