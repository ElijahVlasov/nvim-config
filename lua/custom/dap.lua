local dap = require("dap")

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-dap", -- adjust as needed, must be absolute path
	name = "lldb",
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

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = true,
	},
}

vim.keymap.set("n", "<F5>", function()
	dap.continue()
end)
vim.keymap.set("n", "<F6>", function()
	dap.step_over()
	vim.api.nvim_input("zz")
end)
vim.keymap.set("n", "<F7>", function()
	dap.step_into()
	vim.api.nvim_input("zz")
end)
vim.keymap.set("n", "<F8>", function()
	dap.step_out()
	vim.api.nvim_input("zz")
end)
vim.keymap.set("n", "<Leader>b", function()
	dap.toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>dr", function()
	dap.repl.open()
end)

local dapui = require("dapui")

vim.keymap.set("n", "<LocalLeader>u", dapui.toggle)
vim.keymap.set("n", "<LocalLeader>s", dapui.eval)

vim.fn.sign_define("DapBreakpoint", { text = "🚬", texthl = "red", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🚭", texthl = "red", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🦫", texthl = "red", linehl = "", numhl = "" })
