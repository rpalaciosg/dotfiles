return {
  -- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

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
