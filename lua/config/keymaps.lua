vim.g.mapleader = " "
vim.g.maplocalleader = "  "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<S-h>", "<cmd>bprev<CR>")
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>")

vim.keymap.set("n", "P", "p")
vim.keymap.set("n", "p", "P")

vim.keymap.set("n", "<A-i>", "<C-a>")

vim.keymap.set("n", "<localleader>j", function()
	local r, c = unpack(vim.api.nvim_win_get_cursor(0))
	vim.cmd([[norm O]])
	vim.api.nvim_win_set_cursor(0, { r + 1, c })
end)
vim.keymap.set("n", "<localleader>k", function()
	local c = vim.api.nvim_win_get_cursor(0)
	vim.cmd([[norm o]])
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-e>", true, false, true), "n", false)
	vim.api.nvim_win_set_cursor(0, c)
end)

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
vim.keymap.set("n", "<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>hg", "<cmd>Telescope hoogle<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<localleader>pl", function()
	local hash = vim.api.nvim_exec2("Git rev-parse HEAD", { output = true }).output
	local url = vim.api.nvim_exec2("Git remote get-url origin", { output = true }).output
	local full_name = vim.api.nvim_exec2("Git ls-files --full-name %", { output = true }).output
	local _, line = unpack(vim.api.nvim_win_get_cursor(0))

	if string.sub(url, 1, string.len("https://")) == "https://" then
		url = url:gsub("%.git", "")
	else
		url = url:gsub(":", "/"):gsub("git@", "https://"):gsub("%.git", "")
	end

	local full_url = url .. "/blob/" .. hash .. "/" .. full_name .. "#L" .. line

	vim.fn.setreg("+", full_url)
end)
