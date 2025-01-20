return {

  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, {
  --       "c_sharp",
  --     })
  --   end,
  -- },
  -- add any tools you want to have installed below
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {
          enabled = true,
        },
      },
    },
  },
}
