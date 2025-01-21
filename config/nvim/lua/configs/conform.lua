local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    js = { "prettierd"},
    ts = { "prettierd"},
    javascript = { "prettierd"},
    javascriptreact = { "prettierd"},
    typescript = { "prettierd"},
    typescriptreact = { "prettierd"},
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
