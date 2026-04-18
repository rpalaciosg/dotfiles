return {
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
  -----------------------------------
  -- lualine: statusline in bottom --
  -- Plugin: lualine.nvim
  -- URL: https://github.com/nvim-lualine/lualine.nvim
  -- Description: A blazing fast and easy to configure Neovim statusline plugin.
  -----------------------------------
  {
    "nvim-lualine/lualine.nvim",
    event = "BufReadPre", -- Load this plugin on the 'VeryLazy' event
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")
      local lazy_status = require("lazy.status") -- to configure lazy pending updates count
      -- local kanagawa_paper = require("lualine.themes.kanagawa-paper-ink")

      local colors = {
        normal = { fg = "#363646", bg = "#9fb5c9" }, -- sumiInk5, lotusBlue3
        insert = { fg = "#363646", bg = "#6e915f" }, -- sumiInk5, lotusGreen2
        visual = { fg = "#363646", bg = "#b35b79" }, -- sumiInk5, lotusPink
        command = { fg = "#363646", bg = "#cc6d00" }, -- sumiInk5, lotusOrange
        replace = { fg = "#363646", bg = "#d7474b" }, -- sumiInk5, lotusRed2
        inactive = { fg = "#8a8980", bg = "#363646" }, -- lotusGray3, sumiInk5
      }

      local my_lualine_theme = {
        normal = {
          a = { bg = colors.normal.bg, fg = colors.normal.fg, gui = "bold" },
          b = { bg = colors.inactive.bg, fg = colors.inactive.fg },
          c = { bg = colors.inactive.bg, fg = colors.inactive.fg },
        },
        insert = {
          a = { bg = colors.insert.bg, fg = colors.insert.fg, gui = "bold" },
          b = { bg = colors.inactive.bg, fg = colors.inactive.fg },
          c = { bg = colors.inactive.bg, fg = colors.inactive.fg },
        },
        visual = {
          a = { bg = colors.visual.bg, fg = colors.visual.fg, gui = "bold" },
          b = { bg = colors.inactive.bg, fg = colors.inactive.fg },
          c = { bg = colors.inactive.bg, fg = colors.inactive.fg },
        },
        command = {
          a = { bg = colors.command.bg, fg = colors.command.fg, gui = "bold" },
          b = { bg = colors.inactive.bg, fg = colors.inactive.fg },
          c = { bg = colors.inactive.bg, fg = colors.inactive.fg },
        },
        replace = {
          a = { bg = colors.replace.bg, fg = colors.replace.fg, gui = "bold" },
          b = { bg = colors.inactive.bg, fg = colors.inactive.fg },
          c = { bg = colors.inactive.bg, fg = colors.inactive.fg },
        },
        inactive = {
          a = { bg = colors.inactive.bg, fg = colors.inactive.fg, gui = "bold" },
          b = { bg = colors.inactive.bg, fg = colors.inactive.fg },
          c = { bg = colors.inactive.bg, fg = colors.inactive.fg },
          x = { bg = colors.inactive.bg, fg = colors.inactive.fg },
        },
      }

      lualine.setup({
        options = {
          -- theme = "auto",
          theme = "sonokai",
          -- theme = my_lualine_theme,
          icons_enabled = true,
          ignore_focus = {},
          globalstatus = false,
        },
        extensions = { "quickfix", "fugitive" },
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "starter" },
          winbar = {},
        },
        sections = {
          lualine_a = { { "mode", upper = true } },
          lualine_b = { { "branch", icon = "" }, "db_ui#statusline", "diagnostics", "diff" },
          lualine_c = { { "filename", file_status = true, path = 1 } },
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
            },
            { "encoding" },
            { "fileformat" },
          },
          lualine_y = { "filetype", "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { "filename", file_status = true, path = 1 } },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
      })
    end,
  },
  -------------------------
  -- incline -> filename --
  -------------------------
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("incline").setup({
        window = {
          -- width = 'fill',
          margin = { vertical = 1, horizontal = 1 },
        },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)

          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          return { { icon, guifg = color }, { " " }, { filename }, gui = "normal" }
        end,
      })
    end,
  },
  --
  ---------------------------------------------------------------
  -- Plugin: nvim-docs-view                                    --
  -- URL: https://github.com/amrbashir/nvim-docs-view
  -- Description: A Neovim plugin for viewing documentation.
  ---------------------------------------------------------------
  {
    "amrbashir/nvim-docs-view",
    lazy = true, -- Load this plugin lazily
    cmd = "DocsViewToggle", -- Command to toggle the documentation view
    opts = {
      position = "right", -- Position the documentation view on the right
      width = 60, -- Set the width of the documentation view
    },
  },

  ---------------------
  --- vim-maximizer ---
  ---------------------
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>sm", "<CMD>MaximizerToggle<CR>", desc = "Maximize/minize a split" },
    },
  },
  --------------------
  --- smear-cursor ---
  --------------------
  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  },
}
