return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "jinja-lsp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jinja_lsp = {
          filetypes = { "htmldjango" },
        },
      },
    },
  },
}
