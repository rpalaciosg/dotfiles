-- lua/plugins/coding/dap.lua
-- Debug Adapter Protocol — núcleo
-- DAP movido a <leader>D para no pisar <leader>d (diagnósticos LSP)
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI visual para DAP
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      -- Muestra valores de variables inline mientras depuras
      "theHamsta/nvim-dap-virtual-text",
      -- Integración con Mason para instalar adaptadores
      "jay-babu/mason-nvim-dap.nvim",
    },

    keys = {
      -- ── Ejecución ────────────────────────────────────────────
      -- { "<leader>dbs", "<cmd>DapContinue<CR>", desc = "DAP Start / Continue" },
      -- { "<leader>dbq", "<cmd>DapTerminate<CR>", desc = "DAP Quit / Terminate" },
      -- { "<leader>dbr", "<cmd>DapRestartFrame<CR>", desc = "DAP Restart frame" },
      { "<leader>Ds", "<cmd>DapContinue<CR>", desc = "DAP Start / Continue" },
      { "<leader>Dq", "<cmd>DapTerminate<CR>", desc = "DAP Quit / Terminate" },
      { "<leader>Dr", "<cmd>DapRestartFrame<CR>", desc = "DAP Restart frame" },

      -- ── Stepping ─────────────────────────────────────────────
      -- { "<leader>dbo", "<cmd>DapStepOver<CR>", desc = "DAP Step Over" },
      -- { "<leader>dbi", "<cmd>DapStepInto<CR>", desc = "DAP Step Into" },
      -- { "<leader>dbO", "<cmd>DapStepOut<CR>", desc = "DAP Step Out" },
      { "<leader>Do", "<cmd>DapStepOver<CR>", desc = "DAP Step Over" },
      { "<leader>Di", "<cmd>DapStepInto<CR>", desc = "DAP Step Into" },
      { "<leader>DO", "<cmd>DapStepOut<CR>", desc = "DAP Step Out" },

      -- ── Breakpoints ──────────────────────────────────────────
      -- { "<leader>dbb", "<cmd>DapToggleBreakpoint<CR>", desc = "DAP Toggle breakpoint" },
      { "<leader>Db", "<cmd>DapToggleBreakpoint<CR>", desc = "DAP Toggle breakpoint" },
      {
        -- "<leader>dbB",
        "<leader>DB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "DAP Conditional breakpoint",
      },
      {
        -- "<leader>dbl",
        "<leader>Dl",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end,
        desc = "DAP Log point",
      },
      -- { "<leader>dbx", "<cmd>DapClearBreakpoints<CR>", desc = "DAP Clear all breakpoints" },
      { "<leader>Dx", "<cmd>DapClearBreakpoints<CR>", desc = "DAP Clear all breakpoints" },

      -- ── UI ───────────────────────────────────────────────────
      {
        -- "<leader>dbu",
        "<leader>Du",
        function()
          require("dapui").toggle()
        end,
        desc = "DAP Toggle UI",
      },
      {
        -- "<leader>dbk",
        "<leader>Dk",
        function()
          require("dapui").eval()
        end,
        desc = "DAP Eval expression",
        mode = { "n", "v" },
      },

      -- ── REPL ─────────────────────────────────────────────────
      -- { "<leader>dbR", "<cmd>DapToggleRepl<CR>", desc = "DAP Toggle REPL" },
      { "<leader>DR", "<cmd>DapToggleRepl<CR>", desc = "DAP Toggle REPL" },

      -- ── Frames / Threads ─────────────────────────────────────
      {
        -- "<leader>dbf",
        "<leader>Df",
        function()
          require("dap").focus_frame()
        end,
        desc = "DAP Focus current frame",
      },
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- ── nvim-dap-virtual-text ─────────────────────────────────
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        -- enabled_commands = true,
        highlight_changed_variables = true,
        -- highlight_new_as_changed = false,
        -- commented = false,
        show_stop_reason = true,
        virt_text_pos = "eol",
      })

      -- ── mason-nvim-dap ────────────────────────────────────────
      require("mason-nvim-dap").setup({
        ensure_installed = { "js" },
        automatic_installation = true,
        handlers = {}, -- deja que mason-nvim-dap configure los defaults
      })

      -- ── UI layout ────────────────────────────────────────────
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        layouts = {
          {
            -- Panel lateral izquierdo
            elements = {
              { id = "scopes", size = 0.35 },
              { id = "breakpoints", size = 0.20 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.20 },
            },
            size = 40,
            position = "left",
          },
          {
            -- Panel inferior
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 12,
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.9,
          max_width = 0.9,
          border = "rounded",
          mappings = { close = { "q", "<Esc>" } },
        },
      })

      -- ── Abrir/cerrar UI automáticamente ──────────────────────
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- ── Signos visuales en el gutter ─────────────────────────
      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapLogPoint",
        { text = "◎", texthl = "DapLogPoint", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapStopped",
        { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" }
      )
      vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = "✗", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
      )
    end,
  },
}
