{
  local has_gem
  if [ -n "$vim_gem" ]; then
    has_gem=y
  else
    has_gem=n
  fi

  desc "Solargraph is a Language Server for Ruby: https://solargraph.org"
  ask_bool ruby_solargraph "Install Solargraph?" $has_gem
}
