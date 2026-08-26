return {
	"mrcjkb/rustaceanvim",
	version = "^9", -- Recommended
	lazy = false, -- This plugin is already lazy
	config = function()
		vim.keymap.set("n", "<localleader>c", function()
			vim.cmd.RustLsp("openCargo")
		end)
		vim.keymap.set("n", "<localleader>r", function()
			vim.cmd.RustAnalyzer("restart")
		end)
	end,
}
