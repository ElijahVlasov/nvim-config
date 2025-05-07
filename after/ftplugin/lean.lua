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

vim.api.nvim_buf_create_user_command(0, "Delinearize", function(opts)
	local tab = "  "
	local comm = ".s/\\({\\|(\\)/\\r" .. tab .. "\\1/g"
	vim.cmd(comm)
end, { nargs = 0 })
