local mocha = require "catppuccin.palettes.mocha"
return {
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
-- neo-tree modified
{
 "nvim-neo-tree/neo-tree.nvim",
   dependencies = {
   "nvim-lua/plenary.nvim",
   "nvim-tree/nvim-web-devicons",
   "MunifTanjim/nui.nvim",
   },
 opts = {
     popup_border_style = "rounded",
     enable_git_status = true,
     enable_diagnostics = true,
   window = {
     mappings = {
       ["<space>"] = "none",
     },
   },
   filesystem = {
     filtered_items = {
       visible = true,
       hide_dotfiles = false,
       hide_gitignored = false,
     },
   },
   event_handlers = {
     {
       event = "neo_tree_buffer_enter",
       handler = function()
         vim.opt_local.relativenumber = true
       end,
     },
   },
 },
},

  -- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},
  {
      "rcarriga/nvim-notify",
      opts = {
        timeout = 5000,
      },
  },
  -- animations
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.scroll = {
				enable = false,
			}
		end,
	},

  -- filename
	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		priority = 1000,
		config = function()
			require("incline").setup({
				highlight = {
					groups = {
            InclineNormal = { guibg = "#303030", guifg = "#C0C0C0" },
            InclineNormalNC = { guifg = "#808080", guibg = "#1C1C1C" },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},

}
