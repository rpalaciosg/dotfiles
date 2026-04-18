-- lua/plugins/coding/dap-js.lua
-- Adaptador JavaScript / TypeScript para nvim-dap
-- Cubre: Node.js, ts-node/tsx, nodemon, Jest, Vitest, Next.js, Vue/Nuxt
return {
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    -- ⚠️ SIN dependencia de microsoft/vscode-js-debug
    -- Mason ya instaló js-debug-adapter en stdpath("data")/mason/packages/
    config = function()
      local dap = require("dap")
      local dapjs = require("dap-vscode-js")

      -- ── Adaptador desde Mason (sin compilar nada) ─────────────
      dapjs.setup({
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
        debugger_cmd = { "js-debug-adapter" },
        adapters = {
          "pwa-node",
          "pwa-chrome",
          "pwa-msedge",
          "node-terminal",
          "pwa-extensionHost",
        },
        log_file_level = false,
        log_console_level = vim.log.levels.ERROR,
      })

      -- ════════════════════════════════════════════════════════
      -- CONFIGURACIONES POR TIPO DE PROYECTO
      -- ════════════════════════════════════════════════════════

      -- ── 1. JavaScript puro (Node.js / CommonJS / Express) ───
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "▶ Launch file (node)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "▶ Launch index.js",
          program = "${workspaceFolder}/index.js",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "🔗 Attach to process (pick)",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "🔗 Attach to port 9229",
          port = 9229,
          cwd = "${workspaceFolder}",
          restart = true,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "🧪 Jest (current file)",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/.bin/jest",
            "--runInBand",
            "--testPathPattern",
            "${relativeFile}",
          },
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "🧪 Jest (all tests)",
          runtimeExecutable = "node",
          runtimeArgs = { "./node_modules/.bin/jest", "--runInBand" },
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          cwd = "${workspaceFolder}",
        },
      }

      -- ── 2. TypeScript backend (ts-node / tsx / tsc) ──────────
      dap.configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "▶ Launch with ts-node",
          runtimeExecutable = "node",
          runtimeArgs = { "--loader", "ts-node/esm" },
          args = { "${file}" },
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          sourceMaps = true,
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "▶ Launch with tsx",
          runtimeExecutable = "tsx",
          args = { "${file}" },
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "▶ Launch compiled JS (dist/)",
          program = "${workspaceFolder}/dist/${fileBasenameNoExtension}.js",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          sourceMaps = true,
          outFiles = { "${workspaceFolder}/dist/**/*.js" },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "🔗 Attach to process (pick)",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "🔗 Attach to port 9229",
          port = 9229,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          restart = true,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "▶ NestJS (ts-node)",
          runtimeExecutable = "node",
          runtimeArgs = {
            "--require",
            "ts-node/register",
            "--require",
            "tsconfig-paths/register",
          },
          args = { "${workspaceFolder}/src/main.ts" },
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          sourceMaps = true,
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "🧪 Jest TS (current file)",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/.bin/jest",
            "--runInBand",
            "--testPathPattern",
            "${relativeFile}",
          },
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "🧪 Vitest (current file)",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/.bin/vitest",
            "run",
            "${relativeFile}",
          },
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
      }

      -- ── 3. React / Next.js ────────────────────────────────────
      dap.configurations.typescriptreact = {
        {
          type = "pwa-chrome",
          request = "launch",
          name = "▶ Launch Chrome (localhost:3000)",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          sourceMapPathOverrides = {
            ["webpack:///./~/*"] = "${webRoot}/node_modules/*",
            ["webpack://?:*/*"] = "${webRoot}/*",
            ["webpack:///src/*"] = "${webRoot}/src/*",
          },
        },
        {
          type = "pwa-chrome",
          request = "attach",
          name = "🔗 Attach Chrome (port 9222)",
          port = 9222,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
      }

      -- javascriptreact hereda React
      dap.configurations.javascriptreact = dap.configurations.typescriptreact

      -- ── 4. Vue / Nuxt ─────────────────────────────────────────
      dap.configurations.vue = {
        {
          type = "pwa-chrome",
          request = "launch",
          name = "▶ Launch Chrome (Vite localhost:5173)",
          url = "http://localhost:5173",
          webRoot = "${workspaceFolder}/src",
          sourceMaps = true,
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "▶ Launch Chrome (Nuxt localhost:3000)",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
      }

      -- ── 5. Docker remote attach ───────────────────────────────
      local docker_attach = {
        type = "pwa-node",
        request = "attach",
        name = "🐳 Docker attach (port 9229)",
        port = 9229,
        address = "localhost",
        localRoot = "${workspaceFolder}",
        remoteRoot = "/app", -- ajusta al WORKDIR de tu Dockerfile
        sourceMaps = true,
        restart = false,
      }
      table.insert(dap.configurations.javascript, docker_attach)
      table.insert(dap.configurations.typescript, docker_attach)
    end,
  },
}
