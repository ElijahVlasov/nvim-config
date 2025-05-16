vim.g.mapleader = " "
vim.g.maplocalleader = "  "

vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")

vim.keymap.set("n", "H", "<cmd>bprev<CR>")
vim.keymap.set("n", "L", "<cmd>bnext<CR>")

vim.keymap.set("n", "P", "p")
vim.keymap.set("n", "p", "P")

vim.keymap.set("n", "<A-i>", "<C-a>", { desc = "Avoiding clash with the tmux" })

vim.keymap.set("n", "<leader>puc", function()
	vim.cmd([[colorscheme catppuccin-macchiato]])
end, { desc = "Turn on catppuccin macchiato" })
vim.keymap.set("n", "<leader>mmm", function()
	vim.cmd([[colorscheme fakedonalds]])
end, { desc = "Turn on fakedonalds" })
vim.keymap.set("n", "<leader>cbd", function()
	vim.cmd([[colorscheme carbonized-light]])
end, { desc = "Turn on carbonized light" })

vim.keymap.set("n", "<leader>s", "i <esc>")
vim.keymap.set("n", "<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<localleader>hg", "<cmd>Telescope hoogle<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<localleader>pl", function()
	local hash = vim.api.nvim_exec2("Git rev-parse HEAD", { output = true }).output
	local url = vim.api.nvim_exec2("Git remote get-url origin", { output = true }).output
	local full_name = vim.api.nvim_exec2("Git ls-files --full-name %", { output = true }).output
	local line, _ = unpack(vim.api.nvim_win_get_cursor(0))

	if string.sub(url, 1, string.len("https://")) == "https://" then
		url = url:gsub("%.git", "")
	else
		url = url:gsub(":", "/"):gsub("git@", "https://"):gsub("%.git", "")
	end

	local full_url = url .. "/blob/" .. hash .. "/" .. full_name .. "#L" .. line

	vim.fn.setreg("+", full_url)
end, { desc = "Copy github permalink to current line" })
