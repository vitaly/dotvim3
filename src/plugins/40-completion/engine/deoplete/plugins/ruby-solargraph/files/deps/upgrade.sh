if [ '-' != "$vim_gem" ]; then
  (set -x; $vim_gem_sudo $vim_gem install solargraph)
fi
