return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--background-index-priority=background",
          "-j",
          "1",
          "--malloc-trim",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--function-arg-placeholders=1",
        },
      },
    },
  },
}
