require("snippets")

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "nvim_lsp_signature_help" },
		{ name = "buffer" },
	}),
})

local endhints = require("lsp-endhints")

-- default settings
endhints.setup({
	icons = {
		type = "󰜁 ",
		parameter = "󰏪 ",
		offspec = " ", -- hint kind not defined in official LSP spec
		unknown = " ", -- hint kind is nil
	},
	truncateAtChars = 20,
	label = {
		padding = 1,
		marginLeft = 0,
		sameKindSeparator = ", ",
	},
	extmark = {
		priority = 50,
	},
	autoEnableHints = true,
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "🤡",
			[vim.diagnostic.severity.WARN] = "☢️",
			[vim.diagnostic.severity.HINT] = "🫙",
			[vim.diagnostic.severity.INFO] = "📜",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

endhints.enable()
vim.lsp.inlay_hint.enable()

vim.filetype.add({
	pattern = {
		["*.mli"] = "ocaml_interface",
	},
})

local diagnostic_conf = {
	virtual_text = false,
	signs = false,
	underline = false,
}

vim.keymap.set("n", "<localleader>=", function()
	local tmp = vim.diagnostic.config()
	if tmp then
		vim.diagnostic.config(diagnostic_conf)
		diagnostic_conf = tmp
	else
		print("Something went wrong")
	end
end, { desc = "Toggle LSP diagnostic" })
