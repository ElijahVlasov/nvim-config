-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.lazyvim_check_order = false

-- Setup lazy.nvim
require("lazy").setup({
    spec = {  
        { "folke/lazy.nvim", version = "*" },
        { "LazyVim/LazyVim", priority = 10000, lazy = false, opts = { colorscheme = "catppuccin-macchiato" }, cond = true, version = "*" },
        {
            "folke/snacks.nvim",
            priority = 1000,
            lazy = false,
            opts = {},
            config = function(_, opts)
                local notify = vim.notify
                require("snacks").setup(opts)
                -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
                -- this is needed to have early notifications show up in noice history
                if LazyVim.has("noice.nvim") then
                    vim.notify = notify
                end
            end,
        },
        { import = "plugins" }
    }
})
