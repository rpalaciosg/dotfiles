-- return {
--   {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {
  --       "astro",
  --       "cmake",
  --       "cpp",
  --       "css",
  --       "zim",
  --       "lua",
  --       "gitignore",
  --       "go",
  --       "graphql",
  --       "http",
  --       "java",
  --       "rust",
  --       "php",
  --       "bash",
  --       "python",
  --       "typescript",
  --       "scss",
  --       "sql",
  --       "svelte",
  --       "json",
  --       "json5",
  --       "jsonc",
  --       "latex",
  --       "markdown",
  --       "markdown_inline",
  --       "tsx",
  --       "vue",
  --     },
  --     -- https://github.com/nvim-treesitter/playground#query-linter
  -- 	query_linter = {
  -- 		enable = true,
  -- 		use_virtual_text = true,
  -- 		lint_events = { "BufWrite", "CursorHold" },
  -- 	},


    -- },
  --   config = function(_, opts)
  --     require("nvim-treesitter.configs").setup(opts)
  --
  --     -- MDX
  --     vim.filretype.add({
  --       extension = { mdx = "mdx" },
  --     })
  --     vim.treesitter.language.register('markdown', 'mdx')
  --   end,
  -- }
-- }
-- ============================================
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "scss",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "astro",
        "go",
        "http",
        "sql",
        "vue",
        "cmake",
        "java",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
