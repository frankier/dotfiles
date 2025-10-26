-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local set_autoformat = function(pattern, bool_val)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = pattern,
    callback = function()
      vim.b.autoformat = bool_val
    end,
  })
end

set_autoformat({ "julia" }, false)

ERROR_PATTERN = "^ERROR: "
STACK_TRACE_START_PATTERN = "^Stacktrace:"
STACK_FRAME_PATTERN = [[^\s\+[\d\+\] ]]
STACK_FRAME_LOCATION_PATTERN = [[^\s\+@ \S\+]]

local function stack_trace_jump(backwards)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  if backwards then
    vim.api.nvim_win_set_cursor(0, { row, 0 })
  end
  local match
  while true do
    match = vim.fn.search(STACK_FRAME_PATTERN, "W" .. (backwards and "b" or ""))
    if match == 0 then
      break
    end
    match = vim.fn.search("[", "W", match)
    if match > 0 then
      return true
    end
  end
  vim.api.nvim_win_set_cursor(0, { row, col })
  return false
end

local function stack_trace_location_jump(backwards)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  if backwards then
    vim.api.nvim_win_set_cursor(0, { row, 0 })
  end
  local match
  while true do
    match = vim.fn.search(STACK_FRAME_LOCATION_PATTERN, "W" .. (backwards and "b" or ""))
    if match == 0 then
      break
    end
    match = vim.fn.search([[\S\+:\d\+]], "W", match)
    if match > 0 then
      return true
    end
  end
  vim.api.nvim_win_set_cursor(0, { row, col })
  return false
end

--[[
local function stack_trace_location_jump(backwards)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  if backwards and vim.fn.match(line, STACK_FRAME_LOCATION_PATTERN) ~= -1 then
    vim.api.nvim_win_set_cursor(0, { row - 1, 0 })
  else
    vim.api.nvim_win_set_cursor(0, { row, 0 })
  end
  local match = vim.fn.search(STACK_FRAME_PATTERN, "W" .. (backwards and "b" or ""))
  if match > 0 then
    match = vim.fn.search(STACK_FRAME_LOCATION_PATTERN, "We", match + 1)
    if match > 0 then
      return true
    end
  end
  vim.api.nvim_win_set_cursor(0, { row, col })
  return false
end
--]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = "snacks_terminal",
  callback = function()
    vim.keymap.set("n", "[E", function()
      vim.fn.search(ERROR_PATTERN, "bW")
    end, { noremap = true, silent = true, desc = "Previous Error" })

    vim.keymap.set("n", "]E", function()
      vim.fn.search(ERROR_PATTERN, "W")
    end, { noremap = true, silent = true, desc = "Next Error" })

    vim.keymap.set("n", "[S", function()
      vim.fn.search(STACK_TRACE_START_PATTERN, "bW")
    end, { noremap = true, silent = true, desc = "Previous Stacktrace" })

    vim.keymap.set("n", "]S", function()
      vim.fn.search(STACK_TRACE_START_PATTERN, "W")
    end, { noremap = true, silent = true, desc = "Next Stacktrace" })

    vim.keymap.set("n", "[f", function()
      stack_trace_jump(true)
    end, { noremap = true, silent = true, desc = "Previous stack frame" })

    vim.keymap.set("n", "]f", function()
      stack_trace_jump(false)
    end, { noremap = true, silent = true, desc = "Next stack frame" })

    vim.keymap.set("n", "[F", function()
      stack_trace_location_jump(true)
    end, { noremap = true, silent = true, desc = "Previous stack frame location" })

    vim.keymap.set("n", "]F", function()
      stack_trace_location_jump(false)
    end, { noremap = true, silent = true, desc = "Next stack frame location" })
  end,
})

local Path = require("plenary.path")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "htmldjango",
  callback = function()
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file ~= "" then
      local templates_path = Path:new(current_file):find_upwards("templates")
      if templates_path then
        local templates_dir = tostring(templates_path:absolute())
        local current_path = vim.o.path
        if not string.find(current_path, vim.pesc(templates_dir), 1, true) then
          vim.opt.path:append(templates_dir)
          print("Added to path: " .. templates_dir)
        end
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client ~= nil and client.name == "jinja_lsp" then
              local jinjaSettings = client.config.settings
              if jinjaSettings then
                jinjaSettings.templates = templates_dir
                vim.lsp.buf_notify(0, "workspace/didChangeConfiguration", { settings = jinjaSettings })
                print("Set jinja_lsp templates to: " .. templates_dir)
                print(vim.inspect(jinjaSettings))
              end
            end
          end,
        })
      end
    end
  end,
})
