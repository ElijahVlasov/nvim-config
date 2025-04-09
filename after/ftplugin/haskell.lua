vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

vim.keymap.set("n", "<leader>tb", function ()
    vim.cmd('below split')
    vim.cmd('terminal')
    vim.fn.feedkeys('a')
    local enter = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
    vim.fn.feedkeys('clear' .. enter)
    vim.fn.feedkeys('stack build' .. enter)
end)
