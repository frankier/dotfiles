return {}
--[[return {
  "olimorris/codecompanion.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
  },
  strategies = {
    chat = {
      adapter = "copilot",
    },
  },
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI chat" },
    { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI action panel" },
    { "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "AI add to context" },
  },
}--]]
--[[
    { "<leader>ac", "<Plug>CodeCompanionToggle", mode = "x", desc = "Send Selection" },
    { "<leader>aa", "<Plug>SlimeMotionSend", mode = "n", desc = "Send Text Object" },
--]]
