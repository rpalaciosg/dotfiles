return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = { -- Añade esto si no está presente
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "rcarriga/nvim-notify",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  ---@type snacks.Config
  opts = {
    dashboard = { enabled = false },
    explorer = { enabled = false },
    input = { enabled = true },
    picker = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    statuscolumn = { enabled = false },
    bigfile = { enabled = true },
    lazygit = {
      enabled = true, -- Asegúrate de que esté habilitado
      size = {
        width = 0.9, -- 90% del ancho
        height = 0.9, -- 90% del alto
      },
    },
    indent = { enabled = true },
    scroll = {
      enabled = true,
      opts = {
        minimap_hl = "DiagnosticError",
      },
    },
    words = { enabled = true },
    notifier = { enabled = true },
    zen = { enabled = true, opts = {
      show_statusline = true,
    } },
    notify = {
      enabled = true,
      -- Opciones pasadas al backend 'nvim-notify'
      opts = {
        stages = "fade", -- Mostrar notificaciones con efecto, puedes usar "fade", "slide", "static"
        timeout = 4000, -- Duración de la notificación en milisegundos (ej: 4 segundos)
        top_down = false, -- Las notificaciones aparecen en la parte inferior ('false' = bottom-up)
        background_colour = "Normal", -- Usar fondo transparente
      },
    },
  },
  -- Opcional: Asegúrate de establecer 'nvim-notify' como el proveedor de vim.notify
  config = function(_, opts)
    require("snacks").setup(opts)
    -- Esto es lo que reemplaza la notificación por defecto de Neovim por el estilo de notify
    vim.notify = require("notify")
  end,
  keys = {
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>gg",
      function()
        -- require("snacks.lazygit").toggle()
        Snacks.lazygit()
      end,
      desc = "Toggle Lazygit (Snacks)",
    },
  },
}
