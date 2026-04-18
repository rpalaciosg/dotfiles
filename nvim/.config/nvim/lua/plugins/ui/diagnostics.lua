return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    -- Se carga de forma perezosa ya que depende de que haya diagnósticos.
    -- event = "BufReadPost",
    -- priority = 1000,
    config = function()
      -- 1. Deshabilita el texto virtual nativo de Neovim
      vim.diagnostic.config({ virtual_text = false })

      -- 2. Configura e inicializa el plugin
      require("tiny-inline-diagnostic").setup()

      -- (Opcional) Limpia los diagnósticos al cambiar de buffer,
      -- para mantener la interfaz limpia.
      vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
        pattern = {
          "*.cs", -- C#
          "*.ts", -- TypeScript
          "*.tsx", -- TypeScript React
          "*.js", -- JavaScript
          "*.jsx", -- JavaScript React
          "*.go", -- Go
          "*.sql", -- SQL
          "*.lua", -- Lua (para la config de Neovim)
          "*.html", -- HTML
          "*.json", -- JSON
          "*.yaml", -- YAML
          "*.sh", -- Shell
        },
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          -- -- require("tiny-inline-diagnostic").clear(bufnr)
          -- vim.diagnostic.reset(bufnr)
          local filetype = vim.bo[bufnr].filetype
          local buflisted = vim.bo[bufnr].buflisted
          if
            buflisted
            and filetype ~= ""
            and pcall(require, "vim.diagnostic")
            and vim.diagnostic.is_active
            and vim.diagnostic.is_active(bufnr)
          then
            vim.diagnostic.reset(bufnr)
          end
        end,
      })
    end,
  },
}
