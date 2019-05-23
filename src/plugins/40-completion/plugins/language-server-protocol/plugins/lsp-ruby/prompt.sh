if [ -n "$vim_gem" ]; then
  desc "Solargraph is a Language Server for Ruby: https://solargraph.org"
  ask_bool lsp_ruby "LSP for ruby" y
fi
