return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			always_show_tabline = true,
			globalstatus = false,
			refresh = {
				statusline = 100,
				tabline = 100,
				winbar = 100,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				"branch",
				"diff",
				{ "diagnostics", symbols = { error = " ", warn = "", info = " ", hint = " " } },
			},
			lualine_c = { "filename", "lsp_status" },
			lualine_x = {
				{
					function()
						for _, buf in ipairs(vim.api.nvim_list_bufs()) do
							if vim.api.nvim_get_option_value("modified", { buf = buf }) then
								return "Unsaved bufs 🥷🏼" -- any message or icon
							end
						end
						return ""
					end,
				},
			},
			lualine_y = { "encoding" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	},
	config = function(_, opts)
		require("lualine").setup(opts)
		vim.opt_global.showmode = false
	end,
}
