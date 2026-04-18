return {
  ------------------------
  --- indent-blankline ---
  ------------------------
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      indent = {
        char = "▏", -- Alternativas: "┊", "│", "┆", "┇"
        tab_char = "▏",
        -- highlight = "IndentLine", -- definiremos este highlight abajo
        smart_indent_cap = true,
      },
      whitespace = {
        remove_blankline_trail = true,
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        -- highlight = { "Function", "Label" },
      },
      exclude = {
        filetypes = {
          "help",
          "neo-tree",
          "dashboard",
          "lazy",
          "mason",
          "nvdash",
          "alpha",
        },
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)

      -- Colores personalizados (ajústalos si usas otro colorscheme)
      vim.api.nvim_set_hl(0, "IndentLine", { fg = "#3c3c4e", nocombine = true }) -- línea tenue
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#7e9cd8", nocombine = true }) -- scope azul (como kanagawa.crystalBlue)
    end,
  },

  ------------------
  --- MINI.ICONS ---
  ------------------
  {
    "echasnovski/mini.icons",
    event = "VeryLazy",
    config = true,
  },
  ----------------
  -- MINI.PAIRS --
  ----------------
  {
    "echasnovski/mini.pairs",
    version = "*",
    config = function()
      local mpairs = require("mini.pairs")
      -- Estado de mini.pairs (activo por defecto)
      local mini_pairs_enabled = true
      mpairs.setup({
        -- Configuración personalizada (ver documentación)
        modes = { insert = true, command = false, terminal = false },
        -- skip autopair when next character is one of these
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        -- skip autopair when the cursor is inside these treesitter nodes
        skip_ts = { "string" },
        -- skip autopair when next character is closing pair
        -- and there are more closing pairs than opening pairs
        skip_unbalanced = true,
        -- better deal with markdown code blocks
        markdown = true,
        mappings = {
          ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
          ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
          ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

          [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
          ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
          ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

          ['"'] = {
            action = "closeopen",
            pair = '""',
            neigh_pattern = "[^\\].",
            register = { cr = false },
          },
          ["'"] = {
            action = "closeopen",
            pair = "''",
            neigh_pattern = "[^%a\\].",
            register = { cr = false },
          },
          ["`"] = {
            action = "closeopen",
            pair = "``",
            neigh_pattern = "[^\\].",
            register = { cr = false },
          },

          -- Deshabilitar un par (ejemplo)
          -- ['<'] = { action = 'close', pair = '<>', neigh_pattern = '[^\\].' },
        },
      })

      -- 🔀 Keymap para alternar mini.pairs
      vim.keymap.set("n", "<leader>up", function()
        mini_pairs_enabled = not mini_pairs_enabled
        if mini_pairs_enabled then
          mpairs.unmap()
          mini_pairs_enabled = false
          vim.notify("mini.pairs DESACTIVADO", vim.log.levels.WARN, { title = "MiniPairs" })
        else
          mpairs.setup()
          mini_pairs_enabled = true
          vim.notify("mini.pairs ACTIVADO", vim.log.levels.INFO, { title = "MiniPairs" })
        end
        print("Toggle mini.pairs ejecutado")
      end, { desc = "Alternar mini.pairs" })
      -- Integración mínima con nvim-cmp (sólo para funciones)
      local cmp_status, cmp = pcall(require, "cmp")
      if cmp_status then
        cmp.event:on("confirm_done", function(entry, vim_item)
          local kind = entry.get_kind
          local insert_char = vim.api.nvim_get_current_line():sub(
            vim.api.nvim_win_get_cursor(0)[2] + 1,
            vim.api.nvim_win_get_cursor(0)[2] + 1
          )
          -- Solo insertar ( si se confirmó una función (LSP kind 3) y no hay ( ya
          if kind == 3 and insert_char ~= "(" then
            vim.api.nvim_feedkeys("(", "n", true)
          end
        end)
      end
    end,
  },

  -------------
  -- mini.ai --
  -- usar vaf o vif para funciones
  -------------
  -- TODO: verificar las keymaps
  -- TODO: verificar los custom_textobjects comentados
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          f = function()
            -- Función: todo el nodo function de treesitter
            return ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })
          end,
          c = function()
            -- Clase
            return ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })
          end,
          -- o = ai.gen_spec.treesitter({ -- code block
          --   a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          --   i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          -- }),
          -- f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          -- c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          -- t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          -- d = { "%f[%d]%d+" }, -- digits
          -- e = { -- Word with case
          --   { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
          --   "^().*()$",
          -- },
          -- g = { -- Alternativa para selección de buffer completo
          --   function()
          --     return {
          --       from = { line = 1, col = 1 },
          --       to = { line = vim.fn.line('$'), col = vim.fn.col('$') }
          --     }
          --   end,
          --   desc = "Entire buffer"
          -- },
          -- m = ai.gen_spec.treesitter({ a = "@markup.outer", i = "@markup.inner" }), -- para Markdown
          -- u = ai.gen_spec.function_call(), -- u for "Usage"
          -- U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },

  -------------------
  -- mini.surround --
  -- ysaf" → rodea la función con ".
  -------------------
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys", --"gsa", -- Add surrounding in Normal and Visual modes
        delete = "ds", --"gsd", -- Delete surrounding
        replace = "cs", --"gsr", -- Replace surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        update_n_lines = "gsn", -- Update `n_lines`
        suffix_last = "l",
        suffix_next = "n",
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },

  -------------------------
  --- trailspace.nvim ---
  -------------------------
  {
    "echasnovski/mini.trailspace",
    opts = {
      trailspace = {},
    },
    config = function(_, opts)
      -- Habilita el módulo de trailspace
      require("mini.trailspace").setup(opts)
      -- Configurar la eliminación automática al guardar (Recomendado)
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("MiniTrailspaceAutoTrim", { clear = true }),
        pattern = "*", -- Aplica a todos los archivos
        callback = function()
          -- Excluir tipos de archivo donde los espacios finales son importantes
          local ft = vim.bo.filetype
          if ft ~= "markdown" and ft ~= "tex" and ft ~= "help" then
            require("mini.trailspace").trim()
          end
        end,
      })
    end,
  },

  -------------------------
  --- Substitute.nvim ---
  --- Se puede usar sobre textobjects: vaf<leader>r sustituye toda la función.
  -------------------------
  {
    "gbprod/substitute.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local substitute = require("substitute")

      substitute.setup()

      local keymap = vim.keymap
      vim.keymap.set("n", "<leader>r", substitute.operator, { desc = "Substitute with motion" })
      vim.keymap.set("n", "<leader>rr", substitute.line, { desc = "Substitute line" })
      vim.keymap.set("n", "<leader>R", substitute.eol, { desc = "Substitute to end of line" })
      vim.keymap.set("x", "<leader>r", substitute.visual, { desc = "Substitute in visual mode" })
    end,
  },

  ------------------
  --- flash.nvim ---
  ------------------
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = true,
        },
        char = {
          jump_labels = true,
          -- f,F,t,T for jump
        },
      },
    },
    -- stylua: ignore
    keys = {
      {"s", mode = {"n", "x", "o"}, function() require("flash").jump() end, desc = "Flash"},
      {"S", mode = {"n", "x", "o"}, function() require("flash").treesitter() end, desc = "Flash treesitter"},
      {"r", mode = "o", function() require("flash").remote() end, desc = "Remote flash"},
      {"R", mode = {"o", "x"}, function() require("flash").treesitter_search() end, desc = "Treesitter Search"},
      {"<c-s>", mode = {"c"}, function() require("flash").toggle() end, desc = "Toogle Flash Search"},
    },
  },

  --------------------
  --- mini.move ---
  --------------------
  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        left = "<A-h>",
        right = "<A-l>",
        down = "<A-j>",
        up = "<A-k>",
      },
    },
    config = function(_, opts)
      require("mini.move").setup(opts)
    end,
  },

  --------------------
  --- mini.comment ---
  --------------------
  -- Keymaps incluidos: gcc, gc{motion}, gc en visual
  {
    "echasnovski/mini.comment",
    opts = {
      custom_commentstring = function()
        return vim.bo.commentstring -- usa Treesitter + ftplugin
      end,
    },

    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
  ---------------------
  --- todo-comments ---
  ---------------------
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    -- opts = {},
    config = function()
      local todo_comments = require("todo-comments")

      local keymap = vim.keymap -- for conciseness

      -- TODO: add betters comments
      -- HACK: add hack comment
      -- BUG: add bug comment
      -- PERF: fully optimised
      -- NOTE: adding note
      -- FIX: this need fixing
      -- WARNING: ???
      keymap.set("n", "]t", function()
        todo_comments.jump_next()
      end, { desc = "Next todo comment" })

      keymap.set("n", "[t", function()
        todo_comments.jump_prev()
      end, { desc = "Previous todo comment" })

      todo_comments.setup()
    end,
  },

  -----------------------------------
  -- Zen mode with Snacks for nvim --
  -----------------------------------
  -- {
  --   "folke/snacks.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   dependencies = {  -- Añade esto si no está presente
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "rcarriga/nvim-notify",
  --   },
  --   ---@type snacks.Config
  --   -- opts = {
  --   opts = function()
  --     -- Parche para evitar error si 'snacks.deactivate' no existe
  --     local ok, snacks = pcall(require, "snacks")
  --     if not ok then
  --       vim.notify("❌ Snacks failed to load", vim.log.levels.ERROR)
  --       return {}
  --     end
  --
  --     -- Evitar el error en snacks/init.lua:7
  --     pcall(require, "snacks.deactivate")
  --
  --     return {
  --       -- scroll = { enabled = true },
  --       -- words = { enabled = true },
  --       zen = { enabled = true },
  --     }
  --   end,
  --   -- },
  --   keys = {
  --     { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
  --   },
  -- },

  -----------------------------------------------------------
  -- Schemastore: para autocompletado y validacion de json --
  -----------------------------------------------------------
  {
    "b0o/schemastore.nvim",
    lazy = true,
    -- config = function()
    --   require("schemastore").setup({})
    -- end
  },
}

--****************************************************
-- plugins comentados no usados
--****************************************************

-------------------
-- mini.surround --
-- ysaf" → rodea la función con ".
-------------------
-- {
--   "echasnovski/mini.surround",
--   -- keys = {
--   --  { "gsa", mode = { "n", "v" }, desc = "Add surrounding" },
--   --   { "gsd", desc = "Delete surrounding" },
--   --   { "gsf", desc = "Find surrounding (right)" },
--   --   { "gsF", desc = "Find surrounding (left)" },
--   --   { "gsh", desc = "Highlight surrounding" },
--   --   { "gsr", desc = "Replace surrounding" },
--   --   { "gsn", desc = "Update n_lines" },
--   -- },
--   opts = {
--     mappings = {
--       add = "ys",--"gsa", -- Add surrounding in Normal and Visual modes
--       delete = "ds",--"gsd", -- Delete surrounding
--       replace = "cs",--"gsr", -- Replace surrounding
--       find = "gsf", -- Find surrounding (to the right)
--       find_left = "gsF", -- Find surrounding (to the left)
--       highlight = "gsh", -- Highlight surrounding
--       update_n_lines = "gsn", -- Update `n_lines`
--       suffix_last = "l",
--       suffix_next = "n",
--     },
--   },
--   config = function(_,opts)
--     require("mini.surround").setup(opts)
--   end
-- },
--------------------
--- Comment.nvim ---
--------------------
-- {
--   "numToStr/Comment.nvim",
--   event = { "BufReadPre", "BufNewFile"},
--   dependencies = {
--     "JoosepAlviste/nvim-ts-context-commentstring",
--   },
--   config = function()
--     local comment = require("Comment")
--     local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
--     -- enable comment
--     comment.setup({
--       pre_hook = ts_context_commentstring.create_pre_hook(),
--     })
--   end,
-- },}
