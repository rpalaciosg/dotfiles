-- return {
--   {
--     "thesimonho/kanagawa-paper.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {},
--     config = function()
--       require("kanagawa-paper").setup({
--         undercurl = true,
--         transparent = false,
--         gutter = false,
--         dimInactive = true, -- Se desactiva si está en modo transparente
--         terminalColors = true,
--         commentStyle = { italic = true },
--         functionStyle = { italic = false },
--         keywordStyle = { italic = false, bold = false },
--         statementStyle = { italic = false, bold = false },
--         typeStyle = { italic = false },
--         colors = { theme = {}, palette = {} }, -- Personalizar colores si es necesario
--         overrides = function(colors)
--           return { -- Puedes personalizar grupos de resaltado aquí
--           }
--         end,
--       })
--       -- ⚠️ Es importante aplicar el esquema de colores después de configurarlo
--       vim.cmd("colorscheme kanagawa-paper")
--     end,
--   },
-- }
--
return {
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      -- Estilo: "default" | "atlantis" | "andromeda" | "shusia" | "maia" | "espresso"
      vim.g.sonokai_style = "andromeda"
      vim.g.sonokai_enable_italic = false
      vim.g.sonokai_disable_italic_comment = true
      vim.g.sonokai_better_performance = 1
      vim.cmd("colorscheme sonokai")
    end,
  },
}
