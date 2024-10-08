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
    -- add LazyVim and import its plugins
    { 
      "LazyVim/LazyVim", 
      import = "lazyvim.plugins", 
      opts = {
        colorscheme = "catppuccin-mocha",
        news = { lazyvim = true, neovim = true,},
      },
    },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.linting.eslint"},
    { import = "lazyvim.plugins.extras.formatting.prettier"},
    { import = "lazyvim.plugins.extras.lang.typescript"},
    { import = "lazyvim.plugins.extras.lang.json"},
    { import = "lazyvim.plugins.extras.lang.tailwind"},
    { import = "lazyvim.plugins.extras.coding.codeium" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    -- import/override with your plugins
    { import = "plugins" },
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
      disabled_plugins = { "gzip", "matchit", "matchparen", "netrwPlugin", 
        "tarPlugin", "tohtml", "tutor", "zipPlugin", },
    },
  },
  ui = {
		custom_keys = {
			["<localleader>d"] = function(plugin) dd(plugin) end, },
	},
  debug = false,
}

require("lazy").setup(plugins,opts)


-- ================================================
-- require("lazy").setup({
--   spec = {
--     -- add LazyVim and import its plugins
--     { 
--       "LazyVim/LazyVim", 
--       import = "lazyvim.plugins", 
--       opts = {
--         colorscheme = "catppuccin-mocha",
--         news = {
--           lazyvim = true,
--           neovim = true,
--         },
--       },
--     },
--     -- import any extras modules here
--     { import = "lazyvim.plugins.extras.linting.eslint"},
--     { import = "lazyvim.plugins.extras.formatting.prettier"},
--     { import = "lazyvim.plugins.extras.lang.typescript"},
--     { import = "lazyvim.plugins.extras.lang.json"},
--     { import = "lazyvim.plugins.extras.lang.tailwind"},
--     { import = "lazyvim.plugins.extras.coding.codeium" },
--     { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
--     -- import/override with your plugins
--     { import = "plugins" },
--   },
--   defaults = {
--     -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
--     -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
--     lazy = false,
--     -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
--     -- have outdated releases, which may break your Neovim install.
--     version = false, -- always use the latest git commit
--     -- version = "*", -- try installing the latest stable version for plugins that support semver
--   },
--   checker = {
--     enabled = true, -- check for plugin updates periodically
--     notify = false, -- notify on update
--   }, -- automatically check for plugin updates
--   performance = {
--     cache = {
-- 			enabled = true,
-- 			-- disable_events = {},
-- 		},
--     rtp = {
--       -- disable some rtp plugins
--       disabled_plugins = {
--         "gzip",
--         "matchit",
--         "matchparen",
--         "netrwPlugin",
--         "tarPlugin",
--         "tohtml",
--         "tutor",
--         "zipPlugin",
--       },
--     },
--   },
--   ui = {
-- 		custom_keys = {
-- 			["<localleader>d"] = function(plugin)
-- 				dd(plugin)
-- 			end,
-- 		},
-- 	},
--   debug = false,
-- })

vim.cmd("highlight Visual ctermbg=0 guibg=#6441A5")
