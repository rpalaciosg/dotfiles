-- lua/config/vscode.lua
-- Configuración específica para vscode-neovim
-- Se carga solo cuando Neovim corre dentro de VSCode

local M = {}

function M.setup()
  -- Opciones
  vim.opt.shortmess = "sFIcAWt"
  vim.opt.cmdheight = 4
  vim.opt.showmode = false
  vim.opt.showcmd = false
  vim.opt.ruler = false

  vim.cmd([[
    set report=0
    silent! cnoreabbrev <expr> roslyn getcmdtype() == '@' ? 'roslyn' : 'roslyn'
  ]])

  -- Helper local
  local vscode = require("vscode-neovim")
  local function map(mode, lhs, command, desc)
    vim.keymap.set(
      mode,
      lhs,
      ':<C-u>call VSCodeCall("' .. command .. '")<CR>',
      { silent = true, desc = desc }
    )
  end

  -- Definiciones
  map("n", "gd", "editor.action.revealDefinition", "Definición (peek)")
  map("n", "gD", "editor.action.revealDefinitionAside", "Definición en split")

  -- Referencias
  map("n", "gr", "editor.action.referenceSearch.trigger", "Referencias (peek)")
  map("n", "grr", "references-view.find", "Buscar referencias (panel)")
  map("n", "grl", "editor.action.goToReferences", "Ir a referencias (lista)")
  map("n", "grs", "references-view.findReferences", "Referencias en panel lateral")

  -- Implementaciones
  map("n", "gi", "editor.action.goToImplementation", "Implementación (peek)")
  map("n", "gii", "editor.action.goToImplementation", "Ir a implementación (directo)")
  map("n", "gip", "editor.action.peekImplementation", "Peek implementación")

  -- Tipos
  map("n", "gy", "editor.action.goToTypeDefinition", "Tipo (peek)")
  map("n", "gyy", "editor.action.goToTypeDefinition", "Ir a tipo (directo)")
  map("n", "gyp", "editor.action.peekTypeDefinition", "Peek tipo")

  -- Navegación en panel de referencias
  map("n", "]r", "references-view.next", "Siguiente referencia")
  map("n", "[r", "references-view.prev", "Referencia anterior")
  map("n", "<leader>qc", "workbench.action.closePanel", "Cerrar panel")
  map("n", "<leader>qp", "editor.action.closePeek", "Cerrar peek")

  -- LSP y utilidades
  map("n", "K", "editor.action.showHover", "Mostrar documentación")
  map("n", "<F2>", "editor.action.rename", "Renombrar símbolo")
  map({ "n", "v" }, "<leader>ca", "editor.action.codeAction", "Code actions")
  map("n", "[d", "editor.action.marker.prev", "Error anterior")
  map("n", "]d", "editor.action.marker.next", "Error siguiente")
  map("n", "<leader>f", "editor.action.formatDocument", "Formatear documento")
  map("n", "<leader>fs", "workbench.action.showAllSymbols", "Buscar símbolos")
  map("n", "<leader>e", "workbench.view.explorer", "Abrir explorador")
  map("n", "<leader>ff", "workbench.action.quickOpen", "Buscar archivo")

  -- Mapeos con vim.keymap.set directo
  vim.keymap.set(
    "n",
    "<C-]>",
    ':<C-u>call VSCodeCall("editor.action.revealDefinition")<CR>',
    { silent = true, desc = "Ir a definición (C-])" }
  )

  vim.keymap.set(
    "n",
    "<C-t>",
    ':<C-u>call VSCodeCall("workbench.action.navigateBack")<CR>',
    { silent = true, desc = "Volver atrás" }
  )
end

return M
