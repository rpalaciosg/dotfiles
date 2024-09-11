return {
  {
  "stevearc/dressing.nvim",
    opts = {},
  event = "VeryLazy",
  },
{
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function(_, opts)
   local logo = [[
                                                                       
         ████ ██████           █████      ██                     
        ███████████             █████                             
        █████████ ███████████████████ ███   ███████████   
       █████████  ███    █████████████ █████ ██████████████   
      █████████ ██████████ █████████ █████ █████ ████ █████   
    ███████████ ███    ███ █████████ █████ █████ ████ █████  
   ██████  █████████████████████ ████ █████ █████ ████ ██████ 
   ]]
    logo = string.rep("\n", 5) .. logo .. "\n\n"
    opts.config.header = vim.split(logo, "\n")
    opts.config.theme= 'doom'
  end,
	},
}
