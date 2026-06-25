-- Archivo: lua/config/keymap_labels.lua
-- Este archivo centraliza los registros de grupos de which-key por categoría de plugin
-- lua/config/whichkey_labels.lua
-- Spec migrada a which-key v3 (wk.add en lugar de wk.register)
-- Agrega el grupo DAP <leader>db
--TODO: Ver si se puede agregar en el grupo de gitsins <leader>g hs y no <leader>g gs, es decir dejar lo e los hunks de git sings tal cual pero dentro del grupo 'g'

local M = {}

function M.setup()
  local ok, wk = pcall(require, "which-key")
  if not ok then
    vim.notify("which-key no está disponible", vim.log.levels.WARN)
    return
  end

  wk.add({

    -- ══════════════════════════════════════════════════════════
    -- FIND / TELESCOPE  <leader>f
    -- ══════════════════════════════════════════════════════════
    { "<leader>f", group = "Find (Telescope)" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files in cwd" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Open buffers" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "String in cwd" },
    { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Word under cursor" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Search todos" },

    -- ══════════════════════════════════════════════════════════
    -- GIT  <leader>g  (Lazygit + Gitsigns hunks)
    -- ══════════════════════════════════════════════════════════
    { "<leader>g", group = "Git" },
    { "<leader>gg", desc = "Toggle Lazygit" },
    { "<leader>gs", desc = "Stage hunk", mode = { "n", "v" } },
    { "<leader>gr", desc = "Reset hunk", mode = { "n", "v" } },
    { "<leader>gS", desc = "Stage buffer" },
    { "<leader>gR", desc = "Reset buffer" },
    { "<leader>gu", desc = "Undo stage hunk" },
    { "<leader>gp", desc = "Preview hunk" },
    { "<leader>gb", desc = "Blame line (full)" },
    { "<leader>gB", desc = "Toggle line blame" },
    { "<leader>gd", desc = "Diff this" },
    { "<leader>gD", desc = "Diff this ~" },
    { "]h", desc = "Next hunk" },
    { "[h", desc = "Prev hunk" },

    -- ══════════════════════════════════════════════════════════
    -- DIAGNÓSTICOS LSP  <leader>d
    -- ══════════════════════════════════════════════════════════
    { "<leader>d", group = "Diagnostics (LSP)" },
    { "<leader>d", desc = "Line diagnostics" },
    { "<leader>dD", desc = "Buffer diagnostics (Telescope)" },
    { "[d", desc = "Prev diagnostic" },
    { "]d", desc = "Next diagnostic" },

    -- ══════════════════════════════════════════════════════════
    -- DEBUG DAP  <leader>D
    -- ══════════════════════════════════════════════════════════
    { "<leader>D", group = "Debug (DAP)" },
    { "<leader>Ds", desc = "Start / Continue" },
    { "<leader>Dq", desc = "Quit / Terminate" },
    { "<leader>Dr", desc = "Restart frame" },
    { "<leader>Do", desc = "Step Over" },
    { "<leader>Di", desc = "Step Into" },
    { "<leader>DO", desc = "Step Out" },
    { "<leader>Db", desc = "Toggle breakpoint" },
    { "<leader>DB", desc = "Conditional breakpoint" },
    { "<leader>Dl", desc = "Log point" },
    { "<leader>Dx", desc = "Clear all breakpoints" },
    { "<leader>Du", desc = "Toggle UI" },
    { "<leader>Dk", desc = "Eval expression", mode = { "n", "v" } },
    { "<leader>DR", desc = "Toggle REPL" },
    { "<leader>Df", desc = "Focus current frame" },

    -- ══════════════════════════════════════════════════════════
    -- CODE / LSP ACTIONS  <leader>c
    -- ══════════════════════════════════════════════════════════
    { "<leader>c", group = "Code (LSP)" },
    { "<leader>ca", desc = "Code actions", mode = { "n", "v" } },

    -- ══════════════════════════════════════════════════════════
    -- FORMAT  <leader>m
    -- ══════════════════════════════════════════════════════════
    { "<leader>m", group = "Format (conform)" },
    { "<leader>mp", desc = "Format file / range", mode = { "n", "v" } },

    -- ══════════════════════════════════════════════════════════
    -- LINTING  <leader>l
    -- ══════════════════════════════════════════════════════════
    { "<leader>l", desc = "Trigger linting" },

    -- ══════════════════════════════════════════════════════════
    -- TROUBLE  <leader>x
    -- ══════════════════════════════════════════════════════════
    { "<leader>x", group = "Trouble / Lists" },
    { "<leader>xw", desc = "Workspace diagnostics" },
    { "<leader>xd", desc = "Document diagnostics" },
    { "<leader>xq", desc = "Quickfix list" },
    { "<leader>xl", desc = "Location list" },
    { "<leader>xt", desc = "Todos list" },

    -- ══════════════════════════════════════════════════════════
    -- SUBSTITUTE  <leader>r
    -- ══════════════════════════════════════════════════════════
    { "<leader>r", group = "Substitute / Rename" },
    { "<leader>rn", desc = "Rename symbol (LSP)" },
    { "<leader>rs", desc = "Restart LSP" },
    { "<leader>rr", desc = "Substitute line" },
    { "<leader>rR", desc = "Substitute to EOL" },
    { "<leader>r", desc = "Substitute with motion", mode = "o" },
    { "<leader>r", desc = "Substitute in visual mode", mode = "x" },
    { "<leader>r", desc = "Substitute (visual)", mode = "v" },

    -- ══════════════════════════════════════════════════════════
    -- HTTP REQUESTS (kulala)  <leader>r  (solo en .http)
    -- ══════════════════════════════════════════════════════════
    { "<leader>rr", desc = "Run HTTP request", ft = "http" },
    { "<leader>ra", desc = "Run all requests", ft = "http" },
    { "<leader>rp", desc = "Previous request", ft = "http" },
    { "<leader>rn", desc = "Next request", ft = "http" },

    -- ══════════════════════════════════════════════════════════
    -- EXPLORER  <leader>e
    -- ══════════════════════════════════════════════════════════
    { "<leader>e", group = "Explorer (Neo-tree)" },
    { "<leader>ee", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
    { "<leader>ef", "<cmd>Neotree reveal<cr>", desc = "Reveal current file" },
    { "<leader>er", "<cmd>Neotree refresh<cr>", desc = "Refresh filesystem" },
    { "<leader>eg", "<cmd>Neotree git_status<cr>", desc = "Git status" },
    { "<leader>eb", "<cmd>Neotree buffers<cr>", desc = "Buffers" },

    -- ══════════════════════════════════════════════════════════
    -- SPLITS  <leader>s
    -- ══════════════════════════════════════════════════════════
    { "<leader>s", group = "Splits" },
    { "<leader>sv", "<cmd>vsplit<cr>", desc = "Split vertical" },
    { "<leader>sh", "<cmd>split<cr>", desc = "Split horizontal" },
    { "<leader>se", "<C-w>=", desc = "Equal size" },
    { "<leader>sx", "<cmd>close<cr>", desc = "Close split" },

    -- ══════════════════════════════════════════════════════════
    -- TABS  <leader>t
    -- ══════════════════════════════════════════════════════════
    { "<leader>t", group = "Tabs" },
    { "<leader>to", "<cmd>tabnew<cr>", desc = "Open tab" },
    { "<leader>tx", "<cmd>tabclose<cr>", desc = "Close tab" },
    { "<leader>tn", "<cmd>tabnext<cr>", desc = "Next tab" },
    { "<leader>tp", "<cmd>tabprevious<cr>", desc = "Previous tab" },
    { "<leader>tf", "<cmd>tab split<cr>", desc = "Buffer to tab" },

    -- ══════════════════════════════════════════════════════════
    -- SESSIONS  <leader>w
    -- ══════════════════════════════════════════════════════════
    { "<leader>w", group = "Sessions (auto-session)" },
    { "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore session" },
    { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },

    -- ══════════════════════════════════════════════════════════
    -- HARPOON  <leader>h  (pins / marcadores de archivos)
    -- ══════════════════════════════════════════════════════════
    { "<leader>h", desc = "Harpoon: quick menu" },
    { "<leader>a", desc = "Harpoon: pin file" },
    { "<leader>1", desc = "Harpoon: file 1" },
    { "<leader>2", desc = "Harpoon: file 2" },
    { "<leader>3", desc = "Harpoon: file 3" },
    { "<leader>4", desc = "Harpoon: file 4" },
    { "<leader>5", desc = "Harpoon: file 5" },
    { "<leader>6", desc = "Harpoon: file 6" },
    { "<leader>7", desc = "Harpoon: file 7" },

    -- ══════════════════════════════════════════════════════════
    -- UI TOGGLES  <leader>u
    -- ══════════════════════════════════════════════════════════
    { "<leader>u", group = "UI / Toggles" },
    { "<leader>up", desc = "Toggle mini.pairs" },

    -- ══════════════════════════════════════════════════════════
    -- MISC
    -- ══════════════════════════════════════════════════════════
    { "<leader>z", desc = "Toggle Zen Mode" },
    { "<leader>+", "<C-a>", desc = "Increment number" },
    { "<leader>-", "<C-x>", desc = "Decrement number" },
    { "<leader>nh", "<cmd>noh<cr>", desc = "Clear search highlights" },

    -- ══════════════════════════════════════════════════════════
    -- TEXTOBJECTS mini.ai (modos o y x)
    -- ══════════════════════════════════════════════════════════
    { "a", group = "[A]round textobject", mode = { "o", "x" } },
    { "i", group = "[I]nside textobject", mode = { "o", "x" } },
    { "f", group = "Function", mode = { "o", "x" } },
    { "c", group = "Class", mode = { "o", "x" } },
    { "fa", desc = "Around function", mode = { "o", "x" } },
    { "fi", desc = "Inside function", mode = { "o", "x" } },
    { "ca", desc = "Around class", mode = { "o", "x" } },
    { "ci", desc = "Inside class", mode = { "o", "x" } },

    -- ══════════════════════════════════════════════════════════
    -- MINI.SURROUND
    -- ══════════════════════════════════════════════════════════
    { "ys", desc = "Add surrounding" },
    { "ds", desc = "Delete surrounding" },
    { "cs", desc = "Replace surrounding" },
    { "gsf", desc = "Find surrounding (right)" },
    { "gsF", desc = "Find surrounding (left)" },
    { "gsh", desc = "Highlight surrounding" },
    { "gsn", desc = "Update n_lines" },
    { "ys", desc = "Add surrounding", mode = "v" },

    -- ══════════════════════════════════════════════════════════
    -- FLASH.NVIM
    -- ══════════════════════════════════════════════════════════
    { "s", desc = "Flash jump", mode = { "n", "x", "o" } },
    { "S", desc = "Flash treesitter", mode = { "n", "x", "o" } },
    { "r", desc = "Remote flash", mode = "o" },
    { "R", desc = "Treesitter search", mode = { "x", "o" } },
    { "<C-s>", desc = "Toggle Flash search", mode = "c" },

    -- ══════════════════════════════════════════════════════════
    -- MINI.MOVE
    -- ══════════════════════════════════════════════════════════
    { "<A-h>", desc = "Move left", mode = { "n", "v" } },
    { "<A-l>", desc = "Move right", mode = { "n", "v" } },
    { "<A-j>", desc = "Move down", mode = { "n", "v" } },
    { "<A-k>", desc = "Move up", mode = { "n", "v" } },

    -- ══════════════════════════════════════════════════════════
    -- MINI.COMMENT
    -- ══════════════════════════════════════════════════════════
    { "gc", desc = "Comment with motion" },
    { "gcc", desc = "Comment line" },
    { "gc", desc = "Comment selection", mode = "v" },

    -- ══════════════════════════════════════════════════════════
    -- TODO-COMMENTS
    -- ══════════════════════════════════════════════════════════
    { "]t", desc = "Next todo comment" },
    { "[t", desc = "Previous todo comment" },

    -- ══════════════════════════════════════════════════════════
    -- LSP NAVIGATION (sin <leader> — no aparecen en el menú principal)
    -- ══════════════════════════════════════════════════════════
    { "gR", desc = "LSP references" },
    { "gD", desc = "LSP declaration" },
    { "gd", desc = "LSP definitions" },
    { "gi", desc = "LSP implementations" },
    { "gt", desc = "LSP type definitions" },
    { "K", desc = "Show documentation" },
  })
end

return M

---############################################ version hasta Martes 24 de Marzo de 2026 06:01
-- local M = {}
--
-- function M.setup()
--   local ok, wk = pcall(require, "which-key")
--   if not ok then
--     vim.notify("which-key no está disponible", vim.log.levels.WARN)
--     return
--   end
--
--   wk.add({
--
--     -- ══════════════════════════════════════════════════
--     -- MODO NORMAL — grupos y mappings existentes
--     -- ══════════════════════════════════════════════════
--
--     -- Neo-tree
--     { "<leader>e", group = "Explorer" },
--     { "<leader>ee", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
--     { "<leader>ef", "<cmd>Neotree reveal<cr>", desc = "Reveal current file" },
--     { "<leader>er", "<cmd>Neotree refresh<cr>", desc = "Refresh filesystem" },
--     { "<leader>eg", "<cmd>Neotree git_status<cr>", desc = "Git explorer" },
--     { "<leader>eb", "<cmd>Neotree buffers<cr>", desc = "Buffers explorer" },
--
--     -- Splits
--     { "<leader>s", group = "Splits" },
--     { "<leader>sv", "<cmd>vsplit<cr>", desc = "Split vertical" },
--     { "<leader>sh", "<cmd>split<cr>", desc = "Split horizontal" },
--     { "<leader>se", "<C-w>=", desc = "Equal size" },
--     { "<leader>sx", "<cmd>close<cr>", desc = "Close split" },
--
--     -- Tabs
--     { "<leader>t", group = "Tabs" },
--     { "<leader>to", "<cmd>tabnew<cr>", desc = "Open tab" },
--     { "<leader>tx", "<cmd>tabclose<cr>", desc = "Close tab" },
--     { "<leader>tn", "<cmd>tabnext<cr>", desc = "Next tab" },
--     { "<leader>tp", "<cmd>tabprevious<cr>", desc = "Previous tab" },
--     { "<leader>tf", "<cmd>tab split<cr>", desc = "Buffer to tab" },
--
--     -- Auto-session
--     { "<leader>w", group = "Auto-session" },
--     { "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore session for cwd" },
--     { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session for auto session root dir" },
--
--     -- Misc
--     { "<leader>+", "<C-a>", desc = "Increment number" },
--     { "<leader>-", "<C-x>", desc = "Decrement number" },
--     { "<leader>nh", "<cmd>noh<cr>", desc = "Clear search highlights" },
--     { "<leader>z", desc = "Toggle Zen Mode" },
--
--     -- Substitute.nvim
--     { "<leader>r", group = "Substitute" },
--     { "<leader>rr", desc = "Substitute line" },
--     { "<leader>rR", desc = "Substitute to EOL" },
--
--     -- ══════════════════════════════════════════════════
--     -- DEBUG (DAP) — grupo nuevo
--     -- ══════════════════════════════════════════════════
--     { "<leader>db", group = "Debug (DAP)" },
--     { "<leader>dbs", desc = "Start / Continue" },
--     { "<leader>dbq", desc = "Quit / Terminate" },
--     { "<leader>dbr", desc = "Restart frame" },
--     { "<leader>dbo", desc = "Step Over" },
--     { "<leader>dbi", desc = "Step Into" },
--     { "<leader>dbO", desc = "Step Out" },
--     { "<leader>dbb", desc = "Toggle breakpoint" },
--     { "<leader>dbB", desc = "Conditional breakpoint" },
--     { "<leader>dbl", desc = "Log point" },
--     { "<leader>dbx", desc = "Clear all breakpoints" },
--     { "<leader>dbu", desc = "Toggle UI" },
--     { "<leader>dbk", desc = "Eval expression", mode = { "n", "v" } },
--     { "<leader>dbR", desc = "Toggle REPL" },
--     { "<leader>dbf", desc = "Focus current frame" },
--
--     -- ══════════════════════════════════════════════════
--     -- MODOS o y x — mini.ai textobjects
--     -- ══════════════════════════════════════════════════
--     { "a", group = "[A]round textobject", mode = { "o", "x" } },
--     { "i", group = "[I]nside textobject", mode = { "o", "x" } },
--     { "f", group = "Function", mode = { "o", "x" } },
--     { "c", group = "Class", mode = { "o", "x" } },
--     { "fa", desc = "Around function", mode = { "o", "x" } },
--     { "fi", desc = "Inside function", mode = { "o", "x" } },
--     { "ca", desc = "Around class", mode = { "o", "x" } },
--     { "ci", desc = "Inside class", mode = { "o", "x" } },
--
--     -- ══════════════════════════════════════════════════
--     -- mini.surround
--     -- ══════════════════════════════════════════════════
--     { "ys", desc = "Add surrounding" },
--     { "ds", desc = "Delete surrounding" },
--     { "cs", desc = "Replace surrounding" },
--     { "gsf", desc = "Find surrounding (right)" },
--     { "gsF", desc = "Find surrounding (left)" },
--     { "gsh", desc = "Highlight surrounding" },
--     { "gsn", desc = "Update n_lines" },
--     { "ys", desc = "Add surrounding", mode = "v" },
--
--     -- ══════════════════════════════════════════════════
--     -- Flash.nvim
--     -- ══════════════════════════════════════════════════
--     { "s", desc = "Flash jump", mode = { "n", "x", "o" } },
--     { "S", desc = "Flash treesitter", mode = { "n", "x", "o" } },
--     { "r", desc = "Remote flash", mode = "o" },
--     { "R", desc = "Treesitter search", mode = { "x", "o" } },
--     { "<C-s>", desc = "Toggle Flash search", mode = "c" },
--
--     -- ══════════════════════════════════════════════════
--     -- mini.move
--     -- ══════════════════════════════════════════════════
--     { "<A-h>", desc = "Move left", mode = { "n", "v" } },
--     { "<A-l>", desc = "Move right", mode = { "n", "v" } },
--     { "<A-j>", desc = "Move down", mode = { "n", "v" } },
--     { "<A-k>", desc = "Move up", mode = { "n", "v" } },
--
--     -- ══════════════════════════════════════════════════
--     -- mini.comment
--     -- ══════════════════════════════════════════════════
--     { "gc", desc = "Comment with motion" },
--     { "gcc", desc = "Comment line" },
--     { "gc", desc = "Comment selection", mode = "v" },
--
--     -- ══════════════════════════════════════════════════
--     -- Todo-comments
--     -- ══════════════════════════════════════════════════
--     { "]t", desc = "Next todo comment" },
--     { "[t", desc = "Previous todo comment" },
--
--     -- ══════════════════════════════════════════════════
--     -- Substitute — modos extra
--     -- ══════════════════════════════════════════════════
--     { "<leader>r", desc = "Substitute in visual mode", mode = "x" },
--     { "<leader>r", desc = "Substitute (visual)", mode = "v" },
--     { "<leader>r", desc = "Substitute with motion", mode = "o" },
--   })
-- end
--
-- return M
--
--- configuracion antigua
-- local M = {}
--
-- function M.setup()
--   local present, wk = pcall(require, "which-key")
--   if not present then
--     vim.notify("which-key no está disponible", vim.log.levels.WARN)
--     return
--   end
--   -- ================================
--   -- Modo Normal
--   -- ================================
--   -- wk.register({
--   local normal_keymaps = {
--     -- 🟩 Neo-tree group
--     ["<leader>e"] = {
--       name = "+Explorer",
--       e = { "<cmd>Neotree toggle<cr>", "Toggle Neo-tree" },
--       f = { "<cmd>Neotree reveal<cr>", "Reveal current file" },
--       r = { "<cmd>Neotree refresh<cr>", "Refresh filesystem" },
--       g = { "<cmd>Neotree git_status<cr>", "Git explorer" },
--       b = { "<cmd>Neotree buffers<cr>", "Buffers explorer" },
--     },
--
--     -- 🟩 Splits group
--     ["<leader>s"] = {
--       name = "+Splits",
--       v = { "<cmd>vsplit<cr>", "Split vertical" },
--       h = { "<cmd>split<cr>", "Split horizontal" },
--       e = { "<C-w>=", "Equal size" },
--       x = { "<cmd>close<cr>", "Close split" },
--     },
--
--     -- 🟩 Tabs group
--     ["<leader>t"] = {
--       name = "+Tabs",
--       o = { "<cmd>tabnew<cr>", "Open tab" },
--       x = { "<cmd>tabclose<cr>", "Close tab" },
--       n = { "<cmd>tabnext<cr>", "Next tab" },
--       p = { "<cmd>tabprevious<cr>", "Previous tab" },
--       f = { "<cmd>tab split<cr>", "Buffer to tab" },
--     },
--
--     -- 🟩 Auto-session
--     ["<leader>w"] = {
--       name = "+Auto-session nvim",
--       r = { "<cmd>SessionRestore<CR>", "Restore session for cwd"},
--       s = { "<cmd>SessionSave<CR>", "Save session for auto session root dir"},
--     },
--
--     -- 🟩 Increment / Decrement numbers
--     ["<leader>+"] = { "<C-a>", "Increment number" },
--     ["<leader>-"] = { "<C-x>", "Decrement number" },
--
--      -- 🟩 Clear search highlights
--     ["<leader>nh"] = { "<cmd>noh<cr>", "Clear search highlights" },
--
--      -- 🟩 Toggle Zen mode
--      ["<leader>z"] = "Toggle Zen Mode",
--   }
--   wk.register(normal_keymaps, { mode = "n" })
--
--
--
--
--   -- ================================
--   -- Escalable: agregar nuevos grupos
--   -- ================================
--   -- Ejemplo: para un nuevo plugin "telescope"
--   -- local telescope_keymaps = {
--   --   ["<leader>f"] = {
--   --     name = "+Find",
--   --     f = { "<cmd>Telescope find_files<cr>", "Find files" },
--   --     g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
--   --     b = { "<cmd>Telescope buffers<cr>", "Buffers" },
--   --   },
--   -- }
--   -- wk.register(telescope_keymaps, { mode = "n" })
--   -- Normal y visual for Substitute.nvim
--
--   -- ================================
--   -- Mini.ai
--   -- ================================
--   -- Textobjects de mini.ai en Operator-pending (o) y Visual (x)
--     -- usar vaf o vif para funciones
--   wk.register({
--     a = { name = "[A]round textobject" },  -- prefix general 'a'
--     i = { name = "[I]nside textobject" },  -- prefix general 'i'
--     f = { name = "Function", a = "Around function", i = "Inside function" },
--     c = { name = "Class", a = "Around class", i = "Inside class" },
--     -- Puedes agregar más textobjects aquí fácilmente:
--     -- m = { name = "Markup", a = "Around markup", i = "Inside markup" },
--     -- u = { name = "Function call", a = "Around usage", i = "Inside usage" },
--   }, { mode = { "o", "x" } })
--
--   -- ================================
--   -- mini.surround
--   -- ================================
--   -- normal mode
--   wk.register({
--     ["ys"] = "Add surrounding",           -- Normal: agregar
--     ["ds"] = "Delete surrounding",        -- Normal: eliminar
--     ["cs"] = "Replace surrounding",       -- Normal: reemplazar
--     ["gsf"] = "Find surrounding (right)", -- Normal: buscar derecha
--     ["gsF"] = "Find surrounding (left)",  -- Normal: buscar izquierda
--     ["gsh"] = "Highlight surrounding",    -- Normal: resaltar
--     ["gsn"] = "Update n_lines",           -- Normal: actualizar n_lines
--   }, { mode = "n"})
--
--   -- visual mode
--   wk.register({
--     ["ys"] = "Add surrounding", -- Visual: agregar
--   }, { mode = "v"})
--
--   -- ================================
--   -- Substitute.nvim
--   -- ================================
--   -- Normal mode
--   wk.register({
--     ["<leader>r"] = {
--       name = "+Substitute",         -- Grupo principal
--       r = "Substitute line",        -- <leader>rr
--       R = "Substitute to EOL",      -- <leader>R
--       -- operador esperando motion
--       [""] = "Substitute with motion", -- <leader>r
--     },
--   }, { mode = "n" })
--
--   -- Visual mode
--   wk.register({
--     ["<leader>r"] = "Substitute in visual mode", -- <leader>r en visual
--   }, { mode = "x" })
--
--   -- Modo Visual
--   wk.register({
--     ["<leader>r"] = "Substitute (visual)",
--   }, { mode = "v" })
--
--   -- Modo Operador de motions / Textobjects
--   wk.register({
--     ["<leader>r"] = "Substitute with motion",  -- operador de motions
--   }, { mode = "o"})
--
--   -- ================================
--   -- Flash.nvim
--   -- ================================
--   -- Normal, Visual, Operator-pending modes
--   wk.register({
--     ["s"] = "Flash jump",                    -- n, x, o
--     ["S"] = "Flash treesitter",              -- n, x, o
--     ["r"] = "Remote flash",                  -- o
--     ["R"] = "Treesitter search",             -- x, o
--   }, { mode = { "n", "x", "o" } })
--
--   -- Operator-pending exclusivo para 'r'
--   wk.register({
--     ["r"] = "Remote flash",                  -- o
--     ["R"] = "Treesitter search",             -- o
--   }, { mode = "o" })
--
--   -- Command-line mode
--   wk.register({
--     ["<C-s>"] = "Toggle Flash search",      -- c
--   }, { mode = "c" })
--
--   -- ================================
--   -- Mini.move
--   -- ================================
--   -- Mapeos de movimiento de líneas y bloques
--   wk.register({
--     ["<A-h>"] = "Move left",
--     ["<A-l>"] = "Move right",
--     ["<A-j>"] = "Move down",
--     ["<A-k>"] = "Move up",
--   }, { mode = { "n", "v" } }) -- Normal y Visual
--
--   -- ================================
--   -- Mini.comment
--   -- ================================
--   -- Normal mode
--   wk.register({
--     ["gcc"] = "Comment line",           -- línea actual
--     ["gc"] = "Comment with motion",     -- esperar motion
--   }, { mode = "n" })
--
--   -- Visual mode
--   wk.register({
--     ["gc"] = "Comment selection",
--   }, { mode = "v" })
--
--   -- ================================
--   -- Todo-comments.nvim
--   -- ================================
--   -- normal mode
--   wk.register({
--     ["]t"] = "Next todo comment",
--     ["[t"] = "Previous todo comment",
--   }, { mode = "n" })
--
-- end
--
-- return M

--- configuracion antes antes
------------------------------------------
-- Mapa visual de integración y keymaps --
------------------------------------------
-- Normal mode (n)            Visual mode (x)           Operator-pending mode (o)
-- -----------------           ----------------         -------------------------
-- Mini.ai (Textobjects)       Mini.ai (Visual select)  Mini.ai (Operator)
-- a = Around                  i = Inside               a = Around
-- i = Inside                  a = Around               i = Inside
-- f = Function                i = Inside Function      f = Function
-- c = Class                   a = Around Class         c = Class
-- o = Outside                 o = Outside              o = Outside
--
-- Mini.surround
-- ys{motion}{char} = add surround
-- ds{char}       = delete surround
-- cs{old}{new}   = change surround
-- gsf            = Search next surround
-- gsF            = Search before surround

-- Substitute.nvim
-- <leader>r      = substitute operator with (motion)
-- <leader>rr     = substitute line
-- <leader>R      = substitute to EOL
-- x + <leader>r  = substitute visual selection
--
-- Mini.comment
-- gcc            = comment/uncomment line
-- gc{motion}     = comment/uncomment motion
-- gc in visual   = comment/uncomment selection
--
-- Mini.move
-- <Alt-j/k>      = move line down/up
-- <Alt-h/l>      = move block left/right (visual)
--
-- Flash.nvim
-- s              = jump to char/word/line
-- S              = jump with visual usando selection of Treesitter
-- r              = remote jump (treesitter node)
-- R              = Treesitter search (Operator / visual)
-- <C-s>          = Toggle flash search whe use "/"

----------------------------------------------
--- Integración de keymaps: flujo sugerido ---
----------------------------------------------
-- 1. Seleccionar un textobject:
--    vaf (mini.ai: visual function)
--    vac (mini.ai: visual class)
--    i)  (mini.ai: inside parentheses)
--
-- 2. Rodear con surround:
--    ysaf"  → rodea la función seleccionada con comillas
--    ds"    → elimina el surround
--    cs"'   → cambia surround de " a '
--
-- 3. Sustituir con substitute.nvim:
--    vaf<leader>r → sustituye toda la función
--    <leader>rr   → sustituye línea completa
--    <leader>R    → sustituye hasta EOL
--    visual + <leader>r → sustituye selección
--
-- 4. Comentar:
--    gc{motion}   → comenta
--    gcc          → comenta línea
--    visual gc    → comenta selección
--    Detecta TODO con todo-comments.nvim
--
-- 5. Mover bloques:
--    Alt-j / Alt-k → mover línea o bloque
--    Alt-h / Alt-l → mover visual block
--
-- 6. Flash.nvim:
--    s → saltar a palabra/char/line
--    S → saltar con selección
--    r → saltar nodo Treesitter
