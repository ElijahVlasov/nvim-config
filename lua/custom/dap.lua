local dap = require("dap")

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

dap.configurations.c = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
}

vim.keymap.set("n", "<F5>", function()
	dap.continue()
end)
vim.keymap.set("n", "<F6>", function()
	dap.step_over()
end)
vim.keymap.set("n", "<F7>", function()
	dap.step_into()
end)
vim.keymap.set("n", "<F8>", function()
	dap.step_out()
end)
vim.keymap.set("n", "<Leader>b", function()
	dap.toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>dr", function()
	dap.repl.open()
end)

vim.fn.sign_define("DapBreakpoint", { text = "🚬", texthl = "red", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🚭", texthl = "red", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🦫", texthl = "red", linehl = "", numhl = "" })
