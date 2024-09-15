return {
  {"williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list.extend(opts.ensure_installed, {
        "stylua",
        "prettier",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
      })
    end
  }
}
