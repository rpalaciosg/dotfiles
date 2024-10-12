-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

-- Config colorcolumn
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.colorcolumn = "120"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = 0,
      callback = function()
        local max_line_length = 88
        local current_line = vim.api.nvim_get_current_line()
        if #current_line > max_line_length - 15 then
          vim.opt_local.colorcolumn = tostring(max_line_length)
        else
          vim.opt_local.colorcolumn = ""
        end
      end,
    })
  end,
})
