-- local mocha = require("catppuccin.palettes.mocha")
return {
  -- {
  --   "nvimdev/dashboard-nvim",
  --   event = "VimEnter",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   priority = 1000,
  --   opts = function(_, opts)
  --     local logo = [[    󱘎     ⚡       ]]
  --     logo = string.rep("\n", 5) .. logo .. "\n\n"
  --     opts.config = opts.config or {}
  --     opts.config.header = vim.split(logo, "\n")
  --     opts.config.theme = "doom"
  --     return opts
  --   end,
  -- },
-- neo-tree minimal
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  lazy = false, -- neo-tree will lazily load itself
  keys = {
    {
      "<leader>ee",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Toggle Explorer",
      mode = "n", -- Asegura que solo se active en modo normal
      noremap = true, -- Evita recursividad
      silent = true, -- Silencia los mensajes
    },
    {
      "<leader>eg",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true, position="float" })
      end,
      mode = "n", -- Asegura que solo se active en modo normal
      noremap = true, -- Evita recursividad
      silent = true, -- Silencia los mensajes
      desc = "Git Explorer (Neo-tree)",
    },
    {
      "<leader>eb",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true, position="right"})
      end,
      mode = "n", -- Asegura que solo se active en modo normal
      noremap = true, -- Evita recursividad
      silent = true, -- Silencia los mensajes
      desc = "Buffer Explorer (Neo-tree)",
    },
  },
  opts = {
   close_if_last_window = true,
   enable_git_status = true,
    -- Configuración básica
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
      },
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          vim.opt_local.relativenumber = true
        end,
      },
    },
    window = {
      mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<cr>"] = "open",
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
      },
    },
  },
config = function(_, opts)
    require("neo-tree").setup(opts)
    
    -- Verificación de que el keymap se registró
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        if vim.fn.maparg("<leader>e", "n") == "" then
          vim.notify("Neo-tree keymap failed to register!", vim.log.levels.WARN)
        end
      end
    })
  end
},
      
  -- neo-tree modified 
--  {
--     "nvim-neo-tree/neo-tree.nvim",
--     cmd = "Neotree",
--     keys = {
--       {
--         "<leader>ee",
--         function()
--           -- require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), position="left", reveal = true })
--           require("neo-tree.command").execute({ toggle = true, dir = "filesystem", position="left", reveal = true })
--         end,
--         desc = "Toggle file explorer on current file",
--       },
--       {
--     require('neo-tree.command').execute({
--       action = "focus",          -- OPTIONAL, this is the default value
--       source = "filesystem",     -- OPTIONAL, this is the default value
--       position = "left",         -- OPTIONAL, this is the default value
--       reveal_file = reveal_file, -- path to file or folder to reveal
--       reveal_force_cwd = true,   -- change cwd without asking if needed
--     })
--     end,
--     { desc = "Open neo-tree at current file or working directory" }
-- 			},
--
--       -- Keymaps originales de tu configuración (puedes mantenerlos)
--       {
--         "<leader>eg",
--         function()
--           require("neo-tree.command").execute({ source = "git_status", toggle = true, position="float" })
--         end,
--         desc = "Git Explorer",
--       },
--       {
--         "<leader>eb",
--         function()
--           require("neo-tree.command").execute({ source = "buffers", toggle = true, position="right"})
--         end,
--         desc = "Buffer Explorer",
--       },
--     },
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "nvim-tree/nvim-web-devicons",
--       "MunifTanjim/nui.nvim",
--     },
--     deactivate = function()
--       vim.cmd([[Neotree close]])
--     end,
--     init = function()
--       vim.api.nvim_create_autocmd("BufEnter", {
--         group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
--         desc = "Start Neo-tree with directory",
--         once = true,
--         callback = function()
--           if package.loaded["neo-tree"] then
--             return
--           else
--             local stats = vim.uv.fs_stat(vim.fn.argv(0))
--             if stats and stats.type == "directory" then
--               require("neo-tree")
--             end
--           end
--         end,
--       })
--     end,
--     opts = {
--       close_if_last_window = true,
--       sources = { "filesystem", "buffers", "git_status" },
--       open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
--       popup_border_style = "rounded",
--       enable_git_status = true,
--       enable_diagnostics = true,
--       filesystem = {
--         bind_to_cwd = false,
--         follow_current_file = { enabled = true, leave_dirs_open = false },
--         use_libuv_file_watcher = true,
--         filtered_items = {
--           visible = true, -- Show hidden files by default
--           hide_dotfiles = false,
--           hide_gitignored = false,
--         },
--       },
--       event_handlers = {
--         {
--           event = "neo_tree_buffer_enter",
--           handler = function()
--             vim.opt_local.relativenumber = true
--           end,
--         },
--       },
--       window = {
--         mappings = {
--           ["l"] = "open",
--           ["h"] = "close_node",
--           ["<cr>"] = "open",
--           ["<space>"] = "none",
-- 	  ["<esc>"] = "cancel",
--           ["Y"] = {
--             function(state)
--               local node = state.tree:get_node()
--               local path = node:get_id()
--               vim.fn.setreg("+", path, "c")
--             end,
--             desc = "Copy Path to Clipboard",
--           },
--           ["O"] = {
--             function(state)
--               -- Reemplaza lazy.util.open con la función nativa de Neovim
--               local path = state.tree:get_node().path
--               if vim.fn.has("macunix") == 1 then
--                 vim.fn.system({ "open", path })
--               elseif vim.fn.has("linux") == 1 then
--                 vim.fn.system({ "xdg-open", path })
--               elseif vim.fn.has("win32") == 1 then
--                 vim.fn.system({ "explorer", path })
--               end
--             end,
--             desc = "Open with System Application",
--           },
--           ["P"] = { "toggle_preview", config = { use_float = true } },
--         },
--       },
--       default_component_configs = {
--         indent = {
--           with_expanders = true,
--           expander_collapsed = "",
--           expander_expanded = "",
--           expander_highlight = "NeoTreeExpander",
--         },
--         git_status = {
--           symbols = {
--             unstaged = "󰄱",
--             staged = "󰱒",
--           },
--         },
--       },
--     },
--     config = function(_, opts)
--       -- Elimina la dependencia de Snacks (opcional)
--       local function on_move(data)
--         -- Implementación básica sin Snacks
--         vim.notify(("File moved: %s → %s"):format(data.source, data.destination))
--       end
--
--       local events = require("neo-tree.events")
--       opts.event_handlers = opts.event_handlers or {}
--       vim.list_extend(opts.event_handlers, {
--         { event = events.FILE_MOVED, handler = on_move },
--         { event = events.FILE_RENAMED, handler = on_move },
--       })
--
--       require("neo-tree").setup(opts)
--       -- Configuración adicional para which-key
--       local wk = require("which-key")
--       wk.register({
--         ["<leader>e"] = {
--           name = "+explorer",
--           e = "File Explorer",
--           g = "Git Explorer",
--           b = "Buffer Explorer",
--         },
--       })
--
--       vim.api.nvim_create_autocmd("TermClose", {
--         pattern = "*lazygit",
--         callback = function()
--           if package.loaded["neo-tree.sources.git_status"] then
--             require("neo-tree.sources.git_status").refresh()
--           end
--         end,
--       })
--     end,
-- },


  -- messages, cmdline and the popupmenu
  -- Plugin: noice.nvim
  -- URL: https://github.com/folke/noice.nvim
  -- Description: A Neovim plugin for enhancing the command-line UI.
  -- {
  --   "folke/noice.nvim",
  --   opts = function(_, opts)
  --     table.insert(opts.routes, {
  --       filter = {
  --         event = "notify",
  --         find = "No information available",
  --       },
  --       opts = { skip = true },
  --     })
  --     local focused = true
  --     vim.api.nvim_create_autocmd("FocusGained", {
  --       callback = function()
  --         focused = true
  --       end,
  --     })
  --     vim.api.nvim_create_autocmd("FocusLost", {
  --       callback = function()
  --         focused = false
  --       end,
  --     })
  --     table.insert(opts.routes, 1, {
  --       filter = {
  --         cond = function()
  --           return not focused
  --         end,
  --       },
  --       view = "notify_send",
  --       opts = { stop = false },
  --     })
  --
  --     opts.commands = {
  --       all = {
  --         -- options for the message history that you get with `:Noice`
  --         view = "split",
  --         opts = { enter = true, format = "details" },
  --         filter = {},
  --       },
  --     }
  --
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = "markdown",
  --       callback = function(event)
  --         vim.schedule(function()
  --           require("noice.text.markdown").keys(event.buf)
  --         end)
  --       end,
  --     })
  --
  --     opts.presets.lsp_doc_border = true
  --   end,
  -- },

  --Nvim-Notify
  -- {
  --   "rcarriga/nvim-notify",
  --   opts = {
  --     timeout = 5000,
  --   },
  -- },

  -- animations
  -- {
  --   "echasnovski/mini.animate",
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     opts.scroll = {
  --       enable = false,
  --     }
  --   end,
  -- },

  -- buffer line
  -- {
  --   "akinsho/bufferline.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   event = "VeryLazy",
  --   version = "*",
  --   keys = {
  --     { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
  --     { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
  --   },
  --   opts = {
  --     options = {
  --       mode = "tabs",
  --       separator_style = "slant",
  --       show_buffer_close_icons = false,
  --       show_close_icon = false,
  --     },
  --   },
  -- },

  -- filename
  -- {
  --   "b0o/incline.nvim",
  --   event = "BufReadPre",
  --   priority = 1200,
  --   config = function()
  --     -- local colors = require("catppuccin.palettes").get_palette()
  --     local colors = require("kanagawa-paper.colors").setup()
  --     require("incline").setup({
  --       -- highlight = {
  --       --   groups = {
  --       --     InclineNormal = { guibg = colors.pink, guifg = colors.base },
  --       --     InclineNormalNC = { guibg = colors.surface0, guifg = colors.subtext0 },
  --       --   },
  --       -- },
  --       window = { margin = { vertical = 0, horizontal = 1 } },
  --       hide = {
  --         cursorline = true,
  --       },
  --
  --       render = function(props)
  --         local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
  --         local icon, color = require("nvim-web-devicons").get_icon_color(filename)
  --         -- local modified = vim.bo[props.buf].modified
  --         -- local fg = props.focused and colors.base or colors.subtext0
  --         -- local bg = props.focused and colors.pink or colors.surface0
  --
  --         -- local mod_color
  --         -- if modified then
  --         --   mod_color = props.focused and colors.peach or colors.maroon
  --         -- else
  --         --   mod_color = bg
  --         -- end
  --
  --         if vim.bo[props.buf].modified then
  --           filename = "[+] " .. filename
  --           -- filename = filename .. " [+]"
  --         end
  --
  --         -- return {
  --         --   { icon, guifg = color, guibg = bg },
  --         --   { " ", guibg = bg },
  --         --   { filename, gui = modified and "bold,italic" or "bold", guifg = fg, guibg = bg },
  --         --   { modified and " ●" or "  ", guifg = mod_color, guibg = bg },
  --         -- }
  --         return { { icon, guifg = color }, { " " }, { filename } }
  --       end,
  --     })
  --   end,
  -- },

  -- statusline
  -- Plugin: lualine.nvim
  -- URL: https://github.com/nvim-lualine/lualine.nvim
  -- Description: A blazing fast and easy to configure Neovim statusline plugin.
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy", -- Load this plugin on the 'VeryLazy' event
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   opts = function(_, opts)
  --     local LazyVim = require("lazyvim.util")
  --     opts.sections.lualine_c[4] = {
  --       LazyVim.lualine.pretty_path({
  --         length = 0,
  --         relative = "cwd",
  --         modified_hl = "MatchParen",
  --         directory_hl = "",
  --         filename_hl = "Bold",
  --         modified_sign = "",
  --         readonly_icon = " 󰌾 ",
  --       }),
  --     }
  --   end,
  -- },

  -- Plugin: nvim-docs-view
  -- URL: https://github.com/amrbashir/nvim-docs-view
  -- Description: A Neovim plugin for viewing documentation.
  -- {
  --   "amrbashir/nvim-docs-view",
  --   lazy = true, -- Load this plugin lazily
  --   cmd = "DocsViewToggle", -- Command to toggle the documentation view
  --   opts = {
  --     position = "right", -- Position the documentation view on the right
  --     width = 60, -- Set the width of the documentation view
  --   },
  -- },

  -- Zen mode
  -- {
  --   "folke/zen-mode.nvim",
  --   cmd = "ZenMode",
  --   opts = {
  --     plugins = {
  --       gitsigns = true,
  --       tmux = true,
  --       kitty = { enabled = false, font = "+2" },
  --     },
  --   },
  --   keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  -- },


  -- Plugin: folke/which-key.nvim
  -- URL: https://github.com/folke/which-key.nvim
  -- Description: Plugin to show a popup with available keybindings.
  -- IMPORTANT: using event "VeryLazy" to optimize loading time
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     preset = "modern", --"modern", -- Cambiar a "modern"
  --     layout = {
  --       height = { min = 4, max = 25 }, -- Altura mínima y máxima de las columnas
  --       width = { min = 20, max = 50 }, -- Ancho mínimo y máximo de las columnas
  --       spacing = 3, -- Espaciado entre columnas
  --       align = "center", -- Alineación de las columnas
  --     },
  --     window = {
  --       border = "rounded", --"single", -- Tipo de borde (ninguno, sencillo, doble, sombreado, redondeado)
  --       position = "center", -- Posición de la ventana
  --       margin = { 1, 0, 1, 0 }, -- Margen extra de la ventana
  --       padding = { 2, 2, 2, 2 }, -- Relleno extra de la ventana
  --     },
  --     winblend = 10, -- Transparencia
  --     ignore_missing = true,
  --     show_help = true,
  --     show_keys = true,
  --     -- triggers = "auto",
  --   },
  -- },
}
