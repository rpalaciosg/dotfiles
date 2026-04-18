-- Necesitas esta línea para poder llamar a la función on_attach global
local on_attach = require("config.lsponattach").on_attach
return {
  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    -- Solo carga el plugin para archivos C#
    ft = { "cs", "razor", "cshtml" },
    -- cmd = { "Roslyn", "RoslynDebug" }, -- <--- ¡Añade esta línea!
    cmd = { "Roslyn" }, -- <--- ¡Añade esta línea!
    dependencies = {
      -- Necesario para la autocompletación y funcionalidades LSP básicas
      "neovim/nvim-lspconfig",
      -- Recomendado para Razor/Blazor (archivos .razor/.cshtml)
      "tris203/rzls.nvim",
    },
    opts = {
      -- Esto permite que Roslyn.nvim maneje las características
      -- que lspconfig no maneja, como la detección de múltiples soluciones.
      lspconfig = {
        on_attach = on_attach,
        -- Configuración que se pasa al cliente LSP (opcional)
        -- on_attach = function(client, bufnr)
        --   -- Asegúrate de que tu función on_attach global esté aquí
        --   -- (Ejemplo de función on_attach de LazyVim o custom)
        --   local util = require("lspconfig.util")
        --
        --   -- Mapeos de teclas LSP estándar (ej. K para hover, gd para definición)
        --   util.make_lambda_call(require("config.lsp").on_attach)(client, bufnr)
        -- end,
        -- Puedes añadir otras opciones de nvim-lspconfig aquí si es necesario
      },

      -- Opciones específicas de Roslyn (ej. Inlay Hints, Code Lens)
      settings = {
        -- Habilitar referencias y pruebas en Code Lens (las etiquetas "2 references", "Run Test")
        dotnet_enable_references_code_lens = true,
        dotnet_enable_tests_code_lens = true,

        -- Sugerencias de tipo implícito (var)
        csharp_enable_inlay_hints_for_implicit_object_creation = true,

        -- Nivel de análisis de diagnósticos (FullSolution es más lento pero completo)
        ["background_analysis.dotnet_compiler_diagnostics_scope"] = "openFiles",
      },
    },
    config = function(_, opts)
      require("roslyn").setup(opts)
      -- Para Razor/Blazor, si lo instalaste
      require("rzls").setup({})
    end,
  },
}
