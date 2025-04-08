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

vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*.hs",
        group = "AutoFormat",
        callback = function()
            vim.fn.jobstart({"fourmolu" , vim.api.nvim_buf_get_name(0)},
                {
                    stdout_buffered = true,
                    on_stdout = function (_, data)
                        if data then
                            vim.api.nvim_buf_set_lines(
                                0,
                                0, -1,
                                false, data)
                            vim.cmd([[silent :noautocmd w]])
                        end
                    end
                }
            ) 
        end,
        }
    )


