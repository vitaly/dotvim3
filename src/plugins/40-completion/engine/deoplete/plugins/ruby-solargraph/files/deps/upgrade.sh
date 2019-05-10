if [ '-' != "$vim_gem" ]; then
  (set -x; $vim_gem install solargraph)
fi
