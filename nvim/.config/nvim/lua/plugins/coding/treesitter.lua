return {
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    -- event = "VeryLazy",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({
        -- enable syntax highlighting
        highlight = { enable = true, },
        -- enable indentation
        indent = { enable = true },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        autotag = { enable = true, },
        -- playground
        playground = {
          enable = true, -- Asegurarse de que playground esté habilitado
          -- position = "float", -- Esto garantiza que se abra como ventana flotante
          disable = {}, -- Si necesitas desactivar algún lenguaje para playground, hazlo aquí
          updatetime = 25, -- Cuánto tiempo esperar después de cada cambio de texto para actualizar playground
          persist_queries = false,
        },
        -- ensure these language parsers are installed
        ensure_installed = {
          "lua",
          "luadoc",
          "json",
          "javascript",
          "typescript",
          "tsx",
          "yaml",
          "html",
          "css",
          "scss",
          "markdown",
          "markdown_inline",
          "graphql",
          "bash",
          "vim",
          "dockerfile",
          "gitignore",
          "query",
          "vimdoc",
          "astro",
          "go",
          "http",
          "sql",
          "cmake",
          "c_sharp",
        },
        -- Habilitar Textobjects
        textobjects = {
          select = { enable = true }, -- Para incremental selection
          swap = { enable = true },   -- Útil para cambiar bloques
          move = { enable = true },
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
  },
}
