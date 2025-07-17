local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    lazyrepo,
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Extras de LazyVIM (versión personalizada)
  -- { import = "plugins.typescript" },  -- Archivo lua/plugins/typescript.lua
  -- { import = "plugins.prettier" },   -- Archivo lua/plugins/prettier.lua

  -- Tus plugins personales (cargados desde lua/plugins/*.lua)
  -- { import = "plugins" },
   { import = "plugins.colorscheme" },
   { import = "plugins.ui" },
   { import = "plugins.init" },
   { import = "plugins.nvim-cmp"},
   { import = "plugins.treesitter" },
   -- { import = "plugins"}
  }

local opts = {
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  change_detection = { notify = false },
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
    custom_keys = {
      ["<localleader>d"] = function(plugin)
        dd(plugin)
      end,
    },
  },
  debug = false,
}


require("lazy").setup(plugins, opts)

vim.cmd("highlight Visual ctermbg=0 guibg=#6441A5")






-- ANTERIOR
-- local plugins = {
--   -- add LazyVim and import its plugins
--   {
--     "LazyVim/LazyVim",
--     import = "lazyvim.plugins", -- opts = { news = { lazyvim = true, neovim = true }},
--   },
--     { "goolord/alpha-nvim", enabled = false },
--   -- import any extras modules here
--   -- Editor plugins
--   -- { import = "lazyvim.plugins.extras.editor.snacks_explorer" },
--   { import = "lazyvim.plugins.extras.editor.snacks_picker" },
--
--   -- Formatting plugins
--   { import = "lazyvim.plugins.extras.formatting.prettier" },
--
--   -- Linting plugins
--   { import = "lazyvim.plugins.extras.linting.eslint" },
--
--   -- Language support plugins
--   { import = "lazyvim.plugins.extras.lang.json" },
--   { import = "lazyvim.plugins.extras.lang.markdown" },
--   { import = "lazyvim.plugins.extras.lang.typescript" },
--   { import = "lazyvim.plugins.extras.lang.tailwind" },
--
--   -- Coding plugins
--   -- { import = "lazyvim.plugins.extras.coding.mini-surround" },
--
--   -- Utility plugins
--   { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
--
--   -- AI plugins
--   -- { import = "lazyvim.plugins.extras.coding.codeium" },
--
--   -- import/override with your plugins
--   { import = "plugins" },
-- }
