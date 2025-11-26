return {
	"ElijahVlasov/oh-my-fugitive.nvim",
	config = function()
		require("ohmyfugitive").setup({
			keymap = "<leader>hello", -- optional: override the default keymap
		})
	end,
}
