local on_attach = require("config.lsponattach").on_attach
return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor", "cshtml" },
    opts = {},
    config = function(_, opts)
      require("roslyn").setup(opts)

      -- NVim 0.12 removed vim.lsp.diagnostic._refresh; polyfill it
      vim.lsp.diagnostic._refresh = function() end

      -- Daemon mode is omitted because the installed Roslyn server 5.8 does not accept --daemon-mode.
      vim.lsp.config("roslyn", {
        cmd = {
          require("roslyn.utils").get_roslyn_lsp_path(),
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
  },
}
