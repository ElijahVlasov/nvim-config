local opts = {
	ensure_installed = {
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
		"tsx",
		"typescript",
		"vim",
		"yaml",
	},
	highlight = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<cr>", -- set to `false` to disable one of the mappings
			node_incremental = "<leader>rn",
			scope_incremental = "<leader>rc",
			node_decremental = "<leader>rm",
		},
	},
}

return {
	"nvim-treesitter/nvim-treesitter",
	opts = opts,
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.vhs = {
			install_info = {
				url = "https://github.com/charmbracelet/tree-sitter-vhs", -- local path or git repo
				files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
				-- optional entries:
				branch = "main", -- default branch in case of git repo if different from master
				generate_requires_npm = false, -- if stand-alone parser without npm dependencies
				requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
			},
			filetype = "vhs", -- if filetype does not match the parser name
		}
	end,
	build = ":TSUpdate",
}
