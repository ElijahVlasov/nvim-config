local fn = vim.fn
local lsp = vim.lsp

local toggle_interface_impementation = function(cmd)
	local client = assert(lsp.get_clients()[1])
	client:request("ocamllsp/switchImplIntf", { fn.expand("%") }, function(err, res, ctx)
		local next = next
		local _, file_uri = next(res)
		if file_uri == nil then
			print("LSP didn't return anything")
		elseif #res == 1 then
			local file_name = vim.uri_to_fname(file_uri)
			if vim.fn.filereadable(file_name) == 0 then
				-- The file is not readable, meaning we probably
				-- have a relative path.
				file_name = string.sub(file_name, 2)
			end

			-- this is stupid because ocaml-lsp returns
			-- file path starting with /
			vim.cmd(cmd .. " " .. file_name)
		else
			print("LSP returned multiple results")
		end
	end)
end

local next_typed_hole = function(direction)
	local client = assert(lsp.get_clients()[1])
	local pos = vim.api.nvim_win_get_cursor(0)
	client:request("ocamllsp/jumpToTypedHole", {
		uri = vim.uri_from_fname(vim.fn.expand("%:p")),
		position = { line = pos[1] - 1, character = pos[2] },
		direction = direction,
	}, function(err, res, ctx)
		if err ~= nil then
			print("Error happened" .. err)
		else
			vim.api.nvim_win_set_cursor(0, { res.start.line + 1, res.start.character })
		end
	end)
end

vim.keymap.set("n", "<localleader>i", function()
	toggle_interface_impementation("e")
end)
vim.keymap.set("n", "<localleader>v", function()
	toggle_interface_impementation("vs")
end)
vim.keymap.set("n", "<leader>n", function()
	next_typed_hole("next")
end)
vim.keymap.set("n", "<leader>p", function()
	next_typed_hole("prev")
end)
