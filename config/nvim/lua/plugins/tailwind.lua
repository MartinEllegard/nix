return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes_include = {
            "html",
            "templ",
            "astro",
            "javascript",
            "typescript",
            "react",
            "svelte",
            "vue",
          },
        },
      },
    },
  },
}
