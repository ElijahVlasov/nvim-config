return {
	"tpope/vim-fugitive",
	event = "BufWinEnter",
	config = function()
		vim.keymap.set("n", "<F10>", "<cmd>Git add %<CR>", { noremap = true, desc = "git add %" })
		vim.keymap.set("n", "<F22>", function()
			vim.cmd("Git add .")
			print("git added everything 🫃🏻")
		end, { noremap = true, desc = "git add ." })
		vim.keymap.set("n", "<F11>", function()
			vim.cmd("Git commit")
			vim.cmd("startinsert")
		end, { noremap = true, desc = "git commit" })
		vim.keymap.set("n", "<F23>", "<cmd>Git commit --amend<CR>", { noremap = true, desc = "git commit --amend" })
		vim.keymap.set("n", "<F12>", "<cmd>Git push<CR>", { noremap = true, desc = "git push" })
		vim.keymap.set(
			"n",
			"<leader>m<F12>",
			"<cmd>Git push origin HEAD:main<CR>",
			{ noremap = true, desc = "Push into main" }
		)
		-- <S-F12>
		vim.keymap.set("n", "<F24>", "<cmd>Git push -f<CR>", { noremap = true, desc = "git push -f" })
	end,
}
