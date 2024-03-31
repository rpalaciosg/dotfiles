-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.g.vscode then
  -- VSCode extension
  -- Configuración específica para la extensión VS Code Neovim
  local vscode = require("vscode-neovim")
  vim.api.nvim_set_keymap("n", "<leader>e", ":VSCodeExplorer<CR>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-f>", ":lua vscode.call('editor.action.formatSelection')<CR><Esc>", {})
  vim.api.nvim_set_keymap("n", "<leader>f", ":lua vscode.call('editor.action.formatSelection')<CR>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-w>gd", ":lua vscode.action('editor.action.revealDefinitionAside')<CR>", {})
  vim.api.nvim_set_keymap(
    "n",
    "?",
    ":lua vscode.action('workbench.action.findInFiles', { args = { query = vim.fn.expand('<cword>') } })<CR>",
    {}
  )
  vim.notify = vscode.notify
else
  -- ordinary Neovim
  -- activo clipboard
  vim.opt.clipboard = "unnamedplus"
end
