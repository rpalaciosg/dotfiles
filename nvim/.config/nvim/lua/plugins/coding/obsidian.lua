return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      dir = "~/obsidian/my_vault", -- vault por defecto (ajustar al tuyo)
      ui = {
        enable = false, -- markview renderiza; evita conflicto de conceallevel (obsidian pide 1-2, markview 3)
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      new_notes_location = "notes_subdir",
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      follow_url_func = function(url)
        vim.fn.jobstart({ "xdg-open", url })
      end,
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true, desc = "Follow wikilink" },
        },
        ["<leader>oo"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true, desc = "Open link" },
        },
        ["<leader>on"] = {
          action = "<cmd>ObsidianNew<CR>",
          opts = { buffer = true, desc = "New note" },
        },
        ["<leader>os"] = {
          action = "<cmd>ObsidianSearch<CR>",
          opts = { buffer = true, desc = "Search notes" },
        },
        ["<leader>ob"] = {
          action = "<cmd>ObsidianBacklinks<CR>",
          opts = { buffer = true, desc = "Backlinks" },
        },
        ["<leader>ot"] = {
          action = "<cmd>ObsidianToday<CR>",
          opts = { buffer = true, desc = "Today note" },
        },
        ["<leader>oc"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true, desc = "Toggle checkbox" },
        },
      },
    },
  },
}
