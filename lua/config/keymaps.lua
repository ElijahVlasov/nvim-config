local paste_symbol = function(c)
	local pos = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local nline = line:sub(0, pos) .. c .. line:sub(pos + 1)
	vim.api.nvim_set_current_line(nline)
end

vim.g.mapleader = " "
vim.g.maplocalleader = "  "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "P", "p")
vim.keymap.set("n", "p", "P")

vim.keymap.set("n", "<leader>puc", function()
	vim.cmd([[colorscheme catppuccin-macchiato]])
end)
vim.keymap.set("n", "<leader>mmm", function()
	vim.cmd([[colorscheme fakedonalds]])
end)
vim.keymap.set("n", "<leader>cbd", function()
	vim.cmd([[colorscheme carbonized-light]])
end)

vim.keymap.set("n", "<leader>s", "i <esc>")
