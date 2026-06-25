if vim.g.vscode then
  return {}
end

return {
  "mistweaverco/kulala.nvim",
  name = "kulala",
  ft = { "http" },
  config = function()
    require("kulala").setup({
      kulala_keymaps = {
        ["Next tab"] = {
          "<Tab>",
          function() require("kulala.ui").show_next_tab() end,
          mode = { "n" },
        },
        ["Previous tab"] = {
          "<S-Tab>",
          function() require("kulala.ui").show_previous_tab() end,
          mode = { "n" },
        },
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "http",
      callback = function()
        local bufopts = { buffer = true, silent = true }
        vim.keymap.set("n", "<leader>rr", require("kulala").run,
          vim.tbl_extend("force", bufopts, { desc = "Run HTTP request" }))
        vim.keymap.set("n", "<leader>ra", require("kulala").run_all,
          vim.tbl_extend("force", bufopts, { desc = "Run all requests" }))
        vim.keymap.set("n", "<leader>rp", require("kulala").jump_prev,
          vim.tbl_extend("force", bufopts, { desc = "Previous request" }))
        vim.keymap.set("n", "<leader>rn", require("kulala").jump_next,
          vim.tbl_extend("force", bufopts, { desc = "Next request" }))
      end,
    })
  end,
}
