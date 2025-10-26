return {
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_no_mappings = true
      vim.g.slime_suggest_default = false
      vim.g.slime_bracketed_paste = true
      vim.g.slime_get_jobid = function()
        local best_buf = nil
        for _, terminal in ipairs(Snacks.terminal.list()) do
          local info = vim.fn.getbufinfo(terminal.buf)[1]
          local has_window = #(info.windows or {}) > 0
          local visible = info.hidden ~= 1
          local active = has_window and visible
          local lastused = info.lastused or 0
          if best_buf == nil or ((active or not best_buf.active) and (lastused > best_buf.lastused)) then
            best_buf = {
              buf = terminal.buf,
              active = active,
              lastused = lastused,
            }
          end
        end
        if best_buf then
          local chan = vim.api.nvim_get_option_value("channel", { buf = best_buf.buf })
          if chan and chan > 0 then
            return chan
          end
        end
      end
    end,
    keys = {
      { "<leader>is", "<Plug>SlimeRegionSend", mode = "x", desc = "Send Selection" },
      { "<leader>it", "<Plug>SlimeMotionSend", mode = "n", desc = "Send Text Object" },
      { "<leader>il", "<Plug>SlimeLineSend", mode = "n", desc = "Send Line" },
      { "<leader>ic", "<Plug>SlimeConfig", mode = "n", desc = "Slime Config" },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>i", group = "slime/interactive", mode = "nx", icon = { icon = "", color = "green" } },
      },
    },
  },
}
