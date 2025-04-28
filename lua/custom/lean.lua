local opts = { -- see below for full configuration options
	mappings = true,
}

require("lean").setup(opts)

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("lean-fix", { clear = true }),
	pattern = { "*.lean" },
	callback = function(args)
		vim.cmd(":%s/->/→/ge")
		vim.cmd(":%s/<-/←/ge")
	end,
})
