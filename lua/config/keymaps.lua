vim.g.mapleader = " "
vim.g.maplocalleader = "  "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("i", "<C-\\>", function()
	vim.cmd(":norm! zza")
end)

vim.keymap.set({ "v", "i", "s" }, "<esc>", "<cmd>lua vim.snippet.stop()<CR><esc>")
-- Remove last search on esc
vim.keymap.set("n", "<esc>", '<cmd>let @/ = ""<CR><cmd>lua vim.snippet.stop()<CR><esc>')

vim.keymap.set("i", "<C-g>c", function()
	vim.cmd(":norm! m`b~``")
end, { desc = "Capitalise the last word" })
vim.keymap.set("i", "<A-v>", "<C-v>")
vim.keymap.set("i", "<C-v>", "<C-r><C-p>+")

vim.keymap.set("n", "H", "<cmd>bprev<CR>")
vim.keymap.set("n", "L", "<cmd>bnext<CR>")

vim.keymap.set("n", "<A-i>", "<C-a>", { desc = "Avoiding clash with the tmux" })
vim.keymap.set({ "n", "i", "v", "c" }, "<C-a>", "<cmd>lua vim.notify('Is tmux running?')<CR><C-a>")

vim.keymap.set("n", "<leader>puc", function()
	vim.cmd([[colorscheme catppuccin-macchiato]])
end, { desc = "Turn on catppuccin macchiato" })
vim.keymap.set("n", "<leader>mmm", function()
	vim.cmd([[colorscheme fakedonalds]])
end, { desc = "Turn on fakedonalds" })
vim.keymap.set("n", "<leader>cbd", function()
	vim.cmd([[colorscheme carbonized-light]])
end, { desc = "Turn on carbonized light" })

vim.keymap.set("n", "<leader>s", "i <esc>", { desc = "Insert one space" })
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

-- Some tmux control
vim.keymap.set({ "n", "i" }, "<F2>", function()
	vim.fn.jobstart("tmux resize-pane -Z")
end, { desc = "Toggle zoom of current tmux pane" })

vim.keymap.set("n", "<leader>tt", function()
	local reg = vim.fn.getreg("+")
	vim.cmd("norm yiw")
	local word = vim.fn.getreg("+")
	if word == "true" then
		word = "false"
	elseif word == "True" then
		word = "False"
	elseif word == "false" then
		word = "true"
	elseif word == "False" then
		word = "True"
	end
	vim.cmd("norm ciw" .. word)

	-- revert everything back
	vim.fn.setreg("+", reg)
end, { desc = "Toggle true/false (True/False) under the cursor" })

vim.keymap.set("n", "<localleader>?", "<cmd>luafile .nvim.lua<CR>", { desc = "Source .nvim.lua" })
vim.keymap.set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
vim.keymap.set("n", "<leader>mp", "<cmd>e $NVIM_CFG/lua/config/keymaps.lua<CR>", { desc = "Open keymaps config" })

-- CRACKED
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "jl", "<Esc>")
vim.keymap.set("i", "jh", "<Esc>")

-- Toggle Oil.nvim
local last_buf = nil
local function toggle_oil()
	if vim.bo.filetype ~= "oil" then
		last_buf = vim.api.nvim_get_current_buf()
		vim.cmd.Oil()
	else
		if last_buf ~= nil then
			vim.api.nvim_set_current_buf(last_buf)
		else
			vim.cmd.Oil()
		end
	end
end

local oilGrp = vim.api.nvim_create_augroup("OilGrp", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function(_args)
		if vim.bo.filetype ~= "oil" then
			last_buf = vim.api.nvim_get_current_buf()
		end
	end,
	group = oilGrp,
})

vim.keymap.set("n", "<F1>", toggle_oil)
vim.keymap.set("n", "<leader>pv", toggle_oil)
