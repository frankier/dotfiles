-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Editor
vim.opt.smoothscroll = false
vim.o.conceallevel = 0

-- Keymaps
vim.g.maplocalleader = ";"

-- PDF viewer
vim.g.vimtex_view_method = "zathura"

-- Firenvim
vim.g.firenvim_config = {
  localSettings = {
    [".*"] = {
      takeover = "never",
    },
  },
}
