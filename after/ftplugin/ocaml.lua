vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*.ml",
        group = "AutoFormat",
        callback = function()
            vim.fn.jobstart("dune fmt")
            print(vim.api.nvim_buf_get_name(0))
            vim.cmd.edit()
        end,
    }
)
