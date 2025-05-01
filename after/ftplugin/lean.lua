local set_local = vim.opt_local

set_local.tabstop = 2
set_local.softtabstop = 2
set_local.shiftwidth = 2
set_local.expandtab = true

vim.keymap.set("i", "<C-,>", " <BS>")

vim.api.nvim_buf_create_user_command(0, "Delinearize", function(opts)
	local tab = "  "
	local comm = ".s/\\({\\|(\\)/\\r" .. tab .. "\\1/g"
	vim.cmd(comm)
end, { nargs = 0 })
