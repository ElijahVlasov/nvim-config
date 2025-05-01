return {
	"tpope/vim-fugitive",
	event = "BufWinEnter",
	config = function()
		vim.keymap.set("n", "<F12>", "<cmd>Git push<CR>", { noremap = true })
		-- <S-F12>
		vim.keymap.set("n", "<F24>", "<cmd>Git push -f<CR>", { noremap = true })
	end,
}
