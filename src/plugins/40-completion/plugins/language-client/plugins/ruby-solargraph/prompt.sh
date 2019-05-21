if [ -n "$vim_gem" ]; then
  desc "Solargraph is a Language Server for Ruby: https://solargraph.org"
  ask_bool ruby_solargraph "Install Solargraph?"y
fi
