return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({ "c", "cpp", "cmake", "diff", "dot", "doxygen", "gitignore", "json", "latex",
            "lua", "make", "markdown", "markdown_inline", "typst" })
    end
}
