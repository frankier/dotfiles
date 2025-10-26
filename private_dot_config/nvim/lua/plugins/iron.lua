--[[
return {
  "Vigemus/iron.nvim",
  cmd = {
    "IronRepl",
    "IronReplHere",
    "IronRestart",
    "IronSend",
    "IronFocus",
    "IronHide",
    "IronWatch",
    "IronAttach",
  },
  keys = {
    "<leader>sc",
    "<leader>sc",
    "<leader>sf",
    "<leader>sl",
    "<leader>su",
    "<leader>sm",
    "<leader>mc",
    "<leader>mc",
    "<leader>md",
    "<leader>s<cr>",
    "<leader>s<space>",
    "<leader>sq",
    "<leader>cl",

    { "<leader>rs", "<cmd>IronRepl<cr>" },
    { "<leader>rr", "<cmd>IronRestart<cr>" },
    { "<leader>rf", "<cmd>IronFocus<cr>" },
    { "<leader>rh", "<cmd>IronHide<cr>" },
  },
  main = "iron.core", -- <== This informs lazy.nvim to use the entrypoint of `iron.core` to load the configuration.
  opts = {
    config = {
      -- Whether a repl should be discarded or not
      scratch_repl = true,
      -- Your repl definitions come here
      repl_definition = {
        sh = {
          -- Can be a table or a function that
          -- returns a table (see below)
          command = { "fish" },
        },
      },
      -- How the repl window will be displayed
      -- See below for more information
      -- repl_open_cmd = require('iron.view').bottom(40),
    },
    -- Iron doesn't set keymaps by default anymore.
    -- You can set them here or manually add keymaps to the functions in iron.core
    keymaps = {
      send_motion = "<leader>sc",
      visual_send = "<leader>sc",
      send_file = "<leader>sf",
      send_line = "<leader>sl",
      send_until_cursor = "<leader>su",
      send_mark = "<leader>sm",
      mark_motion = "<leader>mc",
      mark_visual = "<leader>mc",
      remove_mark = "<leader>md",
      cr = "<leader>s<cr>",
      interrupt = "<leader>s<space>",
      exit = "<leader>sq",
      clear = "<leader>cl",
    },
    -- If the highlight is on, you can change how it looks
    -- For the available options, check nvim_set_hl
    highlight = { italic = true },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
  },
}
--]]
return {}
