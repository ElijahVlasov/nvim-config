vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

local toggle_interface_impementation = function(cmd)
	local client = assert(vim.lsp.get_clients()[1])
	client:request("ocamllsp/switchImplIntf", { vim.fn.expand("%") }, function(err, res, ctx)
		local next = next
		local _, file_uri = next(res)
		if file_uri == nil then
			print("LSP didn't return anything")
		elseif #res == 1 then
			local file_name = vim.uri_to_fname(file_uri)
			-- this is stupid because ocaml-lsp returns
			-- file path starting with /
			vim.cmd(cmd .. " " .. string.sub(file_name, 2))
		else
			print("LSP returned multiple results")
		end
	end)
end

vim.keymap.set("n", "<localleader>i", function()
	toggle_interface_impementation("e")
end)
vim.keymap.set("n", "<localleader>v", function()
	toggle_interface_impementation("vs")
end)
