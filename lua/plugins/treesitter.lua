local opts = {
    ensure_installed = {
        "bash",
        "html",
        "haskell",
        "ocaml",
        "rust",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
    },
}

return {
    "nvim-treesitter/nvim-treesitter",
    opts = opts,
    config = function ()
        require("nvim-treesitter.configs").setup(opts)
    end,
    build = ":TSUpdate"
}
