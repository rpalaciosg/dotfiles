----------------------------------
-- Plugin: folke/which-key.nvim --
-- URL: https://github.com/folke/which-key.nvim
-- Description: Plugin to show a popup with available keybindings.
-- IMPORTANT: using event "VeryLazy" to optimize loading time
----------------------------------
-- lua/plugins/ui/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = 500,
    win = {
      width = { min = 20, max = 50 },
      height = { min = 4, max = 25 },
      col = math.huge,
      row = math.huge,
      border = "rounded",
      padding = { 1, 2 },
      wo = {
        winblend = 10,
      },
    },
    layout = {
      spacing = 3,
      align = "left",
    },
    -- kfilter entradas sin descripcion para no mostrar ruido
    filter = function(mapping)
      return mapping.desc and mapping.desc ~= ""
    end,
    show_help = true,
    show_keys = true, -- agregue nuevo
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
    local ok, labels = pcall(require, "config.whichkey_labels")
    if ok then
      labels.setup()
    end
  end,
}
--- configuracion antigua
-- return {
--   "folke/which-key.nvim",
--   event = "VeryLazy",
--   init = function()
--     vim.o.timeout = true
--     vim.o.timeoutlen = 500
--   end,
--   opts = {
--     preset = "modern",
--     layout = {
--       height = { min = 4, max = 25 }, -- Altura mínima y máxima de las columnas
--       width = { min = 20, max = 50 }, -- Ancho mínimo y máximo de las columnas
--       spacing = 3, -- Espaciado entre columnas
--       align = "center", -- Alineación de las columnas
--       spelling = true, -- opciones adicionales
--     },
--     winblend = 10, -- Transparencia
--     show_help = true,
--   },
--   -- config = function(_, _)
--   --   require("config.keymap_labels").setup()
--   -- end,
--   config = function(_, opts)
--     require("which-key").setup(opts)
--
--     -- Cargar tus etiquetas personalizadas de keymaps
--     local labels_ok, labels = pcall(require, "config.whichkey_labels")
--     if labels_ok then
--       labels.setup()
--     end
--   end,
-- }
