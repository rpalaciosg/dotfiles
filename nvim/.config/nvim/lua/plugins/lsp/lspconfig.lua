-- 🛡️ PROTECCIÓN: Salir inmediatamente si estamos en VSCode
if vim.g.vscode then
  return {}
end

local on_attach = require("config.lsponattach").on_attach

return {
  -- ── mason: instala los binarios ──────────────────────────────
  {
    "williamboman/mason.nvim",
    priority = 100,
    cmd = { "Mason", "MasonUpdate" },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })
    end,
  },

  -- ── mason-tool-installer: formateadores y linters ────────────
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",
          "stylua",
          "pylint",
          "isort",
          "black",
          "eslint_d",
          "js-debug-adapter",
          "roslyn",
        },
        auto_update = true,
        run_on_start = false,
      })
    end,
  },

  -- ── mason-lspconfig: sincroniza mason con vim.lsp ─────────────
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "html",
          "cssls",
          "tailwindcss",
          "svelte",
          "graphql",
          "emmet_ls",
          "prismals",
          "pyright",
          "eslint",
          "jsonls",
          "dockerls",
          "yamlls",
        },
        automatic_enable = false,
      })
    end,
  },

  -- ── nvim-lspconfig + configuración nativa vim.lsp.config ─────
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- cmp_nvim_lsp está disponible aquí porque es dependencia declarada arriba
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnósticos visuales
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })

      -- Configuración base heredada por todos los servidores
      vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- lua_ls
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            completion = { callSnippet = "Replace" },
          },
        },
      })

      -- ts_ls
      vim.lsp.config("ts_ls", {
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
      })

      -- svelte
      vim.lsp.config("svelte", {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
            end,
          })
        end,
      })

      -- graphql
      vim.lsp.config("graphql", {
        filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
      })

      -- emmet_ls
      vim.lsp.config("emmet_ls", {
        filetypes = {
          "html",
          "typescriptreact",
          "javascriptreact",
          "css",
          "sass",
          "scss",
          "less",
          "svelte",
        },
      })

      -- eslint
      vim.lsp.config("eslint", {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          client.server_capabilities.documentFormattingProvider = true
        end,
        root_markers = {
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.json",
          "package.json",
        },
      })

      -- Servidores sin config especial
      local simple_servers = {
        "html",
        "cssls",
        "tailwindcss",
        "prismals",
        "pyright",
        "jsonls",
        "dockerls",
        "yamlls",
      }
      for _, server in ipairs(simple_servers) do
        vim.lsp.config(server, {})
      end

      -- Activar todos
      vim.lsp.enable({
        "lua_ls",
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
        "eslint",
        "jsonls",
        "dockerls",
        "yamlls",
      })
    end,
  },
}
