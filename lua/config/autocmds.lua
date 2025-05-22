local focusGrp = vim.api.nvim_create_augroup("TmuxFocus", { clear = true })

local always_focus = false

local focus = function()
	vim.fn.jobstart("tmux list-panes -F '#F' | grep -q Z || tmux resize-pane -Z")
end

vim.api.nvim_create_autocmd({ "VimResume", "FocusGained" }, {
	callback = function(_args)
		if always_focus then
			focus()
		end
	end,
	group = focusGrp,
})

vim.keymap.set("n", "<F3>", function()
	if always_focus then
		always_focus = false
	else
		always_focus = true
		focus()
	end
end, { desc = "Toggle tmux autofocus" })
