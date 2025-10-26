return {
  { "projekt0n/github-nvim-theme", name = "github-theme" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_light",
    },
  },
  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    version = "1.6.3",
  },
  {
    "tpope/vim-sleuth",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "nvim-mini/mini.pairs",
    enabled = false,
  },
  {
    "glacambre/firenvim",
    lazy = false,
    cond = not not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    keys = {
      {
        "<C-k>",
        function()
          vim.fn["firenvim#focus_page"]()
        end,
        desc = "Focus page",
      },
    },
  },
  { "noice.nvim", cond = not vim.g.started_by_firenvim },
  { "lualine.nvim", cond = not vim.g.started_by_firenvim },
  --[[{
    "stevearc/conform.nvim",
    opts = function()
      return {
        formatters_by_ft = {
          julia = { lsp_format = "never" },
        },
      }
    end,
  },--]]
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<S-Esc>",
        function()
          vim.cmd("stopinsert")
        end,
        mode = { "t" },
        desc = "Shift+Esc to normal mode",
      },
    },
    opts = {
      styles = {
        terminal = {
          keys = {
            gf = function(self)
              local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
              print("cfile", vim.fn.expand("<cfile>"), f)
              if f == "" then
                Snacks.notify.warn("No file under cursor")
              else
                vim.schedule(function()
                  vim.cmd("e " .. f)
                end)
              end
            end,
          },
        },
      },
    },
  },
  --[[
  {
    "folke/snacks.nvim",
    styles = {
      terminal = {
        keys = {
          gf = function(self)
            print("Managed to override keybinding")
            local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
            if f == "" then
              Snacks.notify.warn("No file under cursor")
            else
              vim.schedule(function()
                vim.cmd("e " .. f)
              end)
            end
          end,
        },
      },
    },
  },--]]
  {
    "folke/snacks.nvim",
    opts = {
      styles = {
        terminal = {
          position = "right",
        },
      },
    },
  },
  {
    "folke/edgy.nvim",
    opts = {
      right = {
        {
          ft = "lazyterm",
          title = "LazyTerm",
          size = { width = 0.3 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
      },
    },
  },
}
