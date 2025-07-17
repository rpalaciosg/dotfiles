return {
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("kanagawa-paper").setup({
        undercurl = true,
        transparent = false,
        gutter = false,
        dimInactive = true, -- Se desactiva si está en modo transparente
        terminalColors = true,
        commentStyle = { italic = true },
        functionStyle = { italic = false },
        keywordStyle = { italic = false, bold = false },
        statementStyle = { italic = false, bold = false },
        typeStyle = { italic = false },
        colors = { theme = {}, palette = {} }, -- Personalizar colores si es necesario
        overrides = function()
          return {} -- Puedes personalizar grupos de resaltado aquí
        end,
      })
      -- ⚠️ Es importante aplicar el esquema de colores después de configurarlo
      vim.cmd("colorscheme kanagawa-paper")
    end,
  },
  -- {
  --   "catppuccin/nvim",
  --   lazy = true,
  --   name = "catppuccin",
  --   priority = 1000,
  --   opts = function()
  --     return {
  --       transparent_background = true,
  --       no_italic = false,
  --       no_underline = false,
  --       styles = {
  --         comments = {"italic"},
  --         conditionals = {"italic"},
  --       },
  --       color_overrides = {},
  --       custom_highlights = {},
  --       default_integrations = true,
  --       integrations = {
  --           cmp = true,
  --           gitsigns = true,
  --           nvimtree = true,
  --           treesitter = true,
  --           notify = false,
  --           mini = {
  --             enabled = true,
  --             indentscope_color = "",
  --           },
  --         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     -- colorscheme = "catppuccin-mocha",
  --     colorscheme = "kanagawa-paper",
  --   },
  -- },
}
