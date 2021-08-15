if vim.g['dotvim#autoformat'] == 'formatter' then

  local prettier = function()
    return {
      exe = "npx",
      args = {"prettier", "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
      stdin = true
    }
  end

  local rustfmt = function()
    return {
      exe = "rustfmt",
      args = {"--emit=stdout"},
      stdin = true
    }
  end

  local luafmt = function()
    return {
      exe = "luafmt",
      args = {"--indent-count", vim.o.sw, "--stdin"},
      stdin = true
    }
  end

  require('formatter').setup({
      logging = false,
      filetype = {
        javascript = { prettier },
        rust = { rustfmt },
        lua = { luafmt }
      }
    })
end
