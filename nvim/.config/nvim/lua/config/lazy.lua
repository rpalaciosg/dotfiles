local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out =
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Detectar si estamos en VSCode (necesitamos esta función aquí también)
local function is_vscode()
  return vim.g.vscode ~= nil
end

local plugins = {
  -- Extras de LazyVIM (versión personalizada)
  -- { import = "plugins.typescript" },  -- Archivo lua/plugins/typescript.lua
  -- { import = "plugins.prettier" },   -- Archivo lua/plugins/prettier.lua

  -- Tus plugins personales (cargados desde lua/plugins/*.lua)
  -- { import = "plugins" },
  -- { import = "plugins.coding" },
  { import = "plugins.ui" },
  -- { import = "plugins.lsp" },
}

-- Plugins que solo deben cargarse en Neovim standalone (NO en VSCode)
if not is_vscode() then
  -- Estos imports solo se añaden cuando NO estamos en VSCode
  vim.list_extend(plugins, {
    { import = "plugins" }, -- Plugins generales
    { import = "plugins.coding" }, -- Plugins de coding (LSP, treesitter, etc.)
    { import = "plugins.lsp" }, -- Plugins de LSP (¡Aquí está tu lspconfig.lua!)

    -- Extras de LazyVIM (comentados como estaban)
    -- { import = "plugins.typescript" },
    -- { import = "plugins.prettier" },
  })
end

local opts = {
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  change_detection = {
    enabled = true,
    notify = false, -- silence notify of change
  },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    cache = {
      enabled = true,
      -- disable_events = {},
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
    custom_keys = {
      ["<localleader>d"] = function(plugin)
        -- dd(plugin)
        print(vim.inspect(plugin))
      end,
    },
  },
  debug = false,
}

require("lazy").setup(plugins, opts)
vim.cmd("highlight Visual ctermbg=0 guibg=#6441A5")
