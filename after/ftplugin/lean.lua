local set_local = vim.opt_local

set_local.tabstop = 2
set_local.softtabstop = 2
set_local.shiftwidth = 2
set_local.expandtab = true

vim.keymap.set("i", "<C-,>", " <BS>")

vim.keymap.set("n", "<F1>", function()
	local url = "https://leanprover-community.github.io/mathlib4_docs/"
	vim.fn.jobstart("brave-browser --new-window " .. url)
end, { desc = "Open mathlib4 docs" })

-- vim.keymap.set("n", "<localleader>[", function()
-- remove brackets and paste its trimmed content.
-- doesn't work properly.
-- 	local buf = vim.fn.getreg("z")
-- 	vim.api.nvim_feedkeys('"zyi{', "n", false)
-- 	local content = vim.fn.trim(vim.fn.getreg("z"))
-- 	print(content)
-- 	vim.fn.setreg("z", content)
-- 	vim.api.nvim_feedkeys("da{", "n", false)
-- 	vim.api.nvim_feedkeys('"zp', "n", false)
-- 	vim.fn.setreg("z", buf)
-- end)

vim.api.nvim_buf_create_user_command(0, "Delinearize", function(opts)
	local tab = "  "
	local comm = ".s/\\({\\|(\\)/\\r" .. tab .. "\\1/g"
	vim.cmd(comm)
end, { nargs = 0 })
