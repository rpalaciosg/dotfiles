-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.loader then
  vim.loader.enable()
end

-- _G.dd = function(...)
-- 	require("util.debug").dump(...)
-- end
-- vim.print = _G.dd

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")


-- if vim.g.vscode then
--   -- Configuración específica para la extensión VSCode Neovim
--   -- local vscode = require("vscode-neovim")
-- end
