return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "html", "templ" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          file_types = { "html", "templ" },
        },
        htmx = {
          file_types = { "html", "templ" },
        },
        templ = {
          file_types = { "templ" },
        },
      },
    },
    {
      "williamboman/mason.nvim",
      opts = { ensure_installed = { "goimports", "gofumpt", "delve", "templ", "htmx", "html-lsp" } },
    },
    {
      "stevearc/conform.nvim",
      optional = true,
      opts = {
        formatters_by_ft = {
          go = { "goimports", "gofumpt" },
        },
      },
    },
  },
}
