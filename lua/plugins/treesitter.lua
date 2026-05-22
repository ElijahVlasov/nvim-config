return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				-- Enable treesitter highlighting and disable regex syntax
				pcall(vim.treesitter.start)
				-- Enable treesitter-based indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		local ensureInstalled = {
			"bash",
			"c",
			"html",
			"haskell",
			"ocaml",
			"ocaml_interface",
			"rust",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"tablegen",
			"tsx",
			"typescript",
			"vim",
			"yaml",
		}
		local alreadyInstalled = require("nvim-treesitter.config").get_installed()
		local parsersToInstall = vim.iter(ensureInstalled)
			:filter(function(parser)
				return not vim.tbl_contains(alreadyInstalled, parser)
			end)
			:totable()
		require("nvim-treesitter").install(parsersToInstall)
	end,
	config = function(_, opts)
		require("nvim-treesitter").setup(opts)
	end,
	build = ":TSUpdate",
}
