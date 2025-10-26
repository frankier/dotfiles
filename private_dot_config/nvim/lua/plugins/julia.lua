local M = {}

function M.lsp_activate(...)
  local ok, res = pcall(vim.cmd.LspJuliaActivateEnv, ...)
  if ok then
    return
  end
  if res ~= "Command not found: LspJuliaActivateEnv" then
    vim.notify(res, vim.log.levels.ERROR)
    return
  end
  local ok, res = pcall(vim.cmd.JuliaActivateEnv, ...)
  if ok then
    return
  end
  if res ~= "Command not found: JuliaActivateEnv" then
    vim.notify(res, vim.log.levels.ERROR)
    return
  end
  vim.notify(
    string.format(
      "Cannot activate with args %s: LspJuliaActivateEnv and JuliaActivateEnv not found (is LSP active? Is current buffer a Julia file?)",
      vim.inspect({ ... })
    ),
    vim.log.levels.ERROR
  )
end

function M.repl(path)
  if path then
    Snacks.terminal({ "julia", "--project=@" .. path }, { cwd = path, win = { position = "bottom" } })
  else
    Snacks.terminal({ "julia", "--project=@." }, { win = { position = "bottom" } })
  end
end

function M.repl_activate(path)
  require("lazy").load({ plugins = { "vim-slime" } })
  if path then
    vim.fn["slime#send"]('using Pkg; Pkg.activate("' .. path .. '")\n')
  else
    vim.fn["slime#send"]('using Pkg; Pkg.activate(".")\n')
  end
end

function M.activate(path)
  M.lsp_activate(path)
  M.repl_activate(path)
end

function M.get_julia_projects()
  local root_files = { "Project.toml", "JuliaProject.toml" }
  local depot_paths = vim.env.JULIA_DEPOT_PATH
      and vim.split(vim.env.JULIA_DEPOT_PATH, vim.fn.has("win32") == 1 and ";" or ":")
    or { vim.fn.expand("~/.julia") }
  local environments = {}
  vim.list_extend(environments, vim.fs.find(root_files, { type = "file", upward = true, limit = math.huge }))
  for _, depot_path in ipairs(depot_paths) do
    local depot_env = vim.fs.joinpath(vim.fs.normalize(depot_path), "environments")
    vim.list_extend(
      environments,
      vim.fs.find(function(name, env_path)
        return vim.tbl_contains(root_files, name) and string.sub(env_path, #depot_env + 1):match("^/[^/]*$")
      end, { path = depot_env, type = "file", limit = math.huge })
    )
  end
  return vim.tbl_map(vim.fs.dirname, environments)
end

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "julia" },
      root = { "Project.toml" },
    })
  end,

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "julia" } },
  },

  {
    "neovim/nvim-lspconfig",
    init = function()
      --environments = get_julia_projects()
      --vim.ui.select(environments, { prompt = 'Select a Julia environment' }, call LspJuliaActivateEnv)
    end,
    opts = {
      servers = {
        julials = {
          settings = {
            -- use the same default settings as the Julia VS Code extension
            julia = {
              completionmode = "qualify",
              lint = { missingrefs = "none" },
            },
          },
        },
      },
    },
    keys = {
      {
        "<localleader>A",
        function()
          M.activate()
        end,
        desc = "Activate Julia Environment (cwd)",
      },
      {
        "<localleader>a",
        function()
          M.activate(LazyVim.root())
        end,
        desc = "Activate Julia Environment (root dir)",
      },
      {
        "<localleader>s",
        function()
          M.activate(M.get_julia_projects())
        end,
        desc = "Select Julia Environment",
      },
      {
        "<localleader>R",
        function()
          M.repl()
        end,
        desc = "Open Julia REPL (cwd)",
      },
      {
        "<localleader>r",
        function()
          M.repl(LazyVim.root())
        end,
        desc = "Open Julia REPL (root dir)",
      },
    },
  },

  --[[
  {
    "https://gitlab.com/ExpandingMan/cmp-latex",
    ft = "julia",
    optional = true,
    init = function()
      -- cmp integration
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "julia",
        callback = function()
          if LazyVim.has_extra("coding.nvim-cmp") then
            local cmp = require("cmp")

            -- global sources
            ---@param source cmp.SourceConfig
            local sources = vim.tbl_map(function(source)
              return { name = source.name }
            end, cmp.get_config().sources)

            -- add latex_symbols source
            table.insert(sources, { name = "latex_symbols" })

            -- update sources for the current buffer
            cmp.setup.buffer({ sources = sources })
          end
        end,
      })
    end,
  },
  --]]
  {
    "kdheepak/cmp-latex-symbols",
    ft = "julia",
    optional = true,
    init = function()
      -- cmp integration
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "julia",
        callback = function()
          if LazyVim.has_extra("coding.nvim-cmp") then
            local cmp = require("cmp")

            -- global sources
            ---@param source cmp.SourceConfig
            local sources = vim.tbl_map(function(source)
              return { name = source.name }
            end, cmp.get_config().sources)

            -- add latex_symbols source
            table.insert(sources, { name = "latex_symbols" })

            -- update sources for the current buffer
            cmp.setup.buffer({ sources = sources })
          end
        end,
      })
    end,
  },

  -- cmp integration
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = { "cmp-latex-symbols" },
  },

  -- blink.cmp integration
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "cmp-latex-symbols", "saghen/blink.compat" },
    opts = {
      sources = {
        per_filetype = {
          julia = { inherit_defaults = true, "latex_symbols" },
        },
        providers = {
          latex_symbols = {
            name = "latex_symbols",
            module = "blink.compat.source",
            score_offset = 200,
          },
        },
      },
    },
  },

  --[[
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        julia = { lsp_format = "never" },
      },
    },
  },
  --]]

  --[[{
    "stevearc/conform.nvim",
    lazy = false,
    --optional = true,
    opts = function(_, opts)
      print(vim.inspect(opts.formatters_by_ft))
      opts.formatters_by_ft["julia"] = { lsp_format = "never" }
      print(vim.inspect(opts.formatters_by_ft))
      return opts
    end,
  },--]]
}
