return {
    "numToStr/Comment.nvim",
    opts = {},
    config = function()
        require("Comment").setup({
            toggler = {
                -- line-comment toggle keymap
                line = "<C-/>",
            },
            -- LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                -- line-comment keymap
                line = "<C-/>",
            },
        })
    end
}
