return {
  ----------------------
  -- neo-tree minimal --
  ----------------------
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
      "<leader>ef",
      function()
        require("neo-tree.command").execute({
          action = "focus",
          source = "filesystem",
          reveal = "file_path",
          toggle = true,
        })
      end,
      desc = "Toggle neo-tree and reveal current file",
      mode = "n",
      noremap = true,
      silent = true,
    },
    {
      "<leader>er",
      function()
        require("neo-tree.command").execute({ action = "refresh_view" }) --({ source = "filesystem", action = "refresh" })
      end,
      desc = "Refresh neo-tree",
      mode = "n",
      noremap = true,
      silent = true,
    },
    {
      "<leader>eg",
      function()
        require("neo-tree.command").execute({
          source = "git_status",
          toggle = true,
          position = "float",
        })
      end,
      mode = "n", -- Asegura que solo se active en modo normal
      noremap = true, -- Evita recursividad
      silent = true, -- Silencia los mensajes
      desc = "Git Explorer (Neo-tree)",
    },
    {
      "<leader>eb",
      function()
        require("neo-tree.command").execute({
          source = "buffers",
          toggle = true,
          position = "right",
        })
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
    popup_border_style = "rounded",
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
      popup = {
        size = {
          height = "40%", -- ✅ popup más agradable
          width = "50%",
        },
        position = "center",
      },
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
        if vim.fn.maparg("<leader>ee", "n") == "" then
          vim.notify("Neo-tree keymap failed to register!", vim.log.levels.WARN)
        end
      end,
    })
  end,
}
