-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.loader then
  vim.loader.enable()
end

local is_vscode = vim.g.vscode ~= nil

-- Cargar configuraciones base (comunes a ambos entornos)
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Polyfill: vim.fs.ext was removed in Neovim 0.12
if not vim.fs.ext then
  vim.fs.ext = function(name)
    return vim.fn.fnamemodify(name, ":e")
  end
end

if is_vscode then
  require("config.vscode").setup()
else
  vim.opt.shortmess:append("c") -- Solo ocultar mensajes de completion menu
  vim.opt.cmdheight = 1 -- Altura normal
  vim.opt.showmode = true -- Mostrar modo
  vim.opt.showcmd = true -- Mostrar comandos
  vim.opt.ruler = true -- Mostrar posición del cursor
  require("config.lazy")
end
