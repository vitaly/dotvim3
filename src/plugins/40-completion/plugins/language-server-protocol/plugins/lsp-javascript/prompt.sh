if [ '-' != "$vim_yarn" ]; then
  desc <<END
javascript-typescript-langserver is used  for javascript LSP
typescript-language-server is used  for typescript LSP
END
  ask_bool lsp_javascript "LSP for javasscript" y
fi
