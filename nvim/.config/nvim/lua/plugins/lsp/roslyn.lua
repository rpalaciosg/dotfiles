local on_attach = require("config.lsponattach").on_attach

-- `init` runs before the plugin is loaded, so its Lua modules are not on rtp yet.
-- Resolve the Mason binary here instead of requiring roslyn.utils.
local mason_dir = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
local mason_server = vim.fs.joinpath(mason_dir, "bin", "roslyn-language-server")
local server_cmd = vim.fn.executable(mason_server) == 1 and mason_server or "roslyn-language-server"

return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor", "cshtml" },
    opts = {},
    init = function()
      -- Daemon mode requires Roslyn server >= 5.12; the installed 5.8 server
      -- rejects --daemon-mode. Apply before vim.lsp.enable() starts the client.
      vim.lsp.config("roslyn", {
        cmd = {
          server_cmd,
          "--stdio",
          "--clientProcessId",
          tostring(vim.uv.os_getpid()),
        },
        on_attach = on_attach,
        settings = {
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
          },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
          },
          ["csharp|background_analysis"] = {
            dotnet_compiler_diagnostics_scope = "openFiles",
          },
        },
      })
    end,
    config = function(_, opts)
      require("roslyn").setup(opts)

      -- NVim 0.12 removed vim.lsp.diagnostic._refresh; polyfill it
      vim.lsp.diagnostic._refresh = function() end
    end,
  },
}
