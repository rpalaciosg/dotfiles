return {
  -- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

  -- Create annotations with one keybind, and jump your cursor in the inserted annotation
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cn",
				function()
					require("neogen").generate({})
				end,
				desc = "Neogen Comment",
			},
		},
		opts = { snippet_engine = "luasnip" },
	},

  -- Refactoring tool
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor({})
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},

-- Go forward/backward with square brackets
	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost",
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" },
				window = { suffix = "" },
				quickfix = { suffix = "" },
				yank = { suffix = "" },
				treesitter = { suffix = "n" },
			})
		end,
	},

  -- Better increase/descrease
	{
		"monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
					augend.constant.new({ elements = { "let", "const" } }),
				},
			})
		end,
	},
  {
		"simrat39/symbols-outline.nvim",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		cmd = "SymbolsOutline",
		opts = {
			position = "right",
		},
	},
  {
		"nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
			table.insert(opts.sources, { name = "emoji" })
		end,
	},
-- -- mason y conform
-- {
--     "williamboman/mason.nvim",
--     opts = function(_, opts)
--       opts.ensure_installed = opts.ensure_installed or {}
--       vim.list_extend(opts.ensure_installed, {
--         "stylua",  -- Formateador para Lua
--         "prettier",  -- Para JavaScript, TypeScript, HTML, CSS, JSON, etc.
--         "black",  -- Para Python
--         "isort",  -- Para Python, ordena las importaciones
--         "shfmt",  -- Para scripts de shell
--       })
--     end,
--   },
-- {
--   "stevearc/conform.nvim",
--   dependencies = { "mason.nvim" },
--   lazy = true,
--   cmd = "ConformInfo",
--   keys = {
--     {
--       "<leader>cF",
--       function()
--         require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
--       end,
--       mode = { "n", "v" },
--       desc = "Format Injected Langs",
--     },
--   },
--   init = function()
--     -- Install the conform formatter on VeryLazy
--     LazyVim.on_very_lazy(function()
--       LazyVim.format.register({
--         name = "conform.nvim",
--         priority = 100,
--         primary = true,
--         format = function(buf)
--           require("conform").format({ bufnr = buf })
--         end,
--         sources = function(buf)
--           local ret = require("conform").list_formatters(buf)
--           ---@param v conform.FormatterInfo
--           return vim.tbl_map(function(v)
--             return v.name
--           end, ret)
--         end,
--       })
--     end)
--   end,
--   opts = function()
--     local plugin = require("lazy.core.config").plugins["conform.nvim"]
--     if plugin.config ~= M.setup then
--       LazyVim.error({
--         "Don't set `plugin.config` for `conform.nvim`.\n",
--         "This will break **LazyVim** formatting.\n",
--         "Please refer to the docs at https://www.lazyvim.org/plugins/formatting",
--       }, { title = "LazyVim" })
--     end
--     ---@type conform.setupOpts
--     local opts = {
--       default_format_opts = {
--         timeout_ms = 3000,
--         async = false, -- not recommended to change
--         quiet = false, -- not recommended to change
--         lsp_format = "fallback", -- not recommended to change
--       },
--       formatters_by_ft = {
--         lua = { "stylua" },
--         fish = { "fish_indent" },
--         sh = { "shfmt" },
--       },
--       -- The options you set here will be merged with the builtin formatters.
--       -- You can also define any custom formatters here.
--       ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
--       formatters = {
--         injected = { options = { ignore_errors = true } },
--         -- # Example of using dprint only when a dprint.json file is present
--         -- dprint = {
--         --   condition = function(ctx)
--         --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
--         --   end,
--         -- },
--         --
--         -- # Example of using shfmt with extra args
--         -- shfmt = {
--         --   prepend_args = { "-i", "2", "-ci" },
--         -- },
--       },
--     }
--     return opts
--   end,
--   config = M.setup,
-- },
  -- conform
-- {
--   "stevearc/conform.nvim",
--   opts = {
--     formatters_by_ft = {
--       lua = { "stylua" },
--       python = { "isort", "black" },
--       javascript = { "prettier" },
--       typescript = { "prettier" },
--       javascriptreact = { "prettier" },
--       typescriptreact = { "prettier" },
--       css = { "prettier" },
--       html = { "prettier" },
--       json = { "prettier" },
--       yaml = { "prettier" },
--       markdown = { "prettier" },
--       ["markdown.mdx"] = { "prettier" },
--       graphql = { "prettier" },
--       handlebars = { "prettier" },
--       cs = { "csharpier" },
--       make = { "checkmake" },
--       dockerfile = { "hadolint" },
--     },
--     format_on_save = {
--       lsp_fallback = true,
--       async = false,
--       timeout_ms = 500,
--     },
--     log_level = vim.log.levels.ERROR,
--     notify_on_error = true,
--   },
--   config = function(_, opts)
--     require("conform").setup(opts)
--     vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
--   end,
-- }
}
