local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

return {
  { "nvim-neotest/nvim-nio" },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      local Config = require("lazyvim.config")
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      for _, language in ipairs(js_based_languages) do
        -- 3 debugging configurations
        dap.configurations[language] = {
          --Debug single nodejs files, just run a js file
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            -- cwd = "${workspaceFolder}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },
          -- Debug nodejs processes (make sure to add --inspect when you run the process), exa: npm run dev, pnpm, yarn, etc
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process",
            processId = require("dap.utils").pick_process,
            -- cwd = "${workspaceFolder}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },
          -- Debug web applications (client side)
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch & Debug Attach to chrome",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = "Enter URL: ",
                  default = "http://localhost:3000",
                }, function(url)
                  if url == nil or url == "" then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            -- webRoot = "${workspaceFolder}",
            webRoot = vim.fn.getcwd(),
            -- skipFiles = { "<node_internals>/* */*.js" },
            protocol = "inspector",
            sourceMaps = true,
            userDataDir = false,
          },
          -- Divider for the launch.json derived confgs
          {
            name = "----- ↓ launch.json configs ↓ -----",
            type = "",
            request = "launch",
          },
        }
      end
    end,
    keys = {
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>da",
        function()
          if vim.fn.filereadable(".vscode/lauch.json") then
            local dap_vscode = require("dap.ext.vscode")
            dap_vscode.load_launchjs(nil, {
              ["pwa-node"] = js_based_languages,
              ["node"] = js_based_languages,
              ["chrome"] = js_based_languages,
              ["pwa-chrome"] = js_based_languages,
            })
          end
          require("dap").continue()
        end,
        desc = "Run with Args",
      },
    },
    dependencies = {
      -- install the vscode-js-debug-adapter
      {
        "microsoft/vscode-js-debug",
        -- After install, build it and rename the dist directory to out
        -- build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
        build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
        version = "1.*",
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("dap-vscode-js").setup({
            -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            -- node_path = "node",
            --
            -- Path to vscode-js-debug installation.
            debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/vscode-js-debug"),
            -- debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lua/richard/vscode-js-debug"),
            -- debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

            -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
            -- debugger_cmd = { "js-debug-adapter" }
            --
            -- which adapters to register in nvim-dap
            adapters = {
              "chrome",
              "pwa-node",
              "pwa-chrome",
              "pwa-msedge",
              "pwa-extensionHost",
              "node-terminal",
              "node",
            },

            -- Path for file logging
            -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

            -- Logging level for output to file. Set to false to disable logging.
            -- log_file_level = false,

            -- Logging level for output to console. Set to false to disable console output.
            -- log_console_level = vim.log.levels.ERROR,
          })
        end,
      },
      {
        "Joakker/lua-json5",
        build = "./install.sh",
      },
    },
  },
}
