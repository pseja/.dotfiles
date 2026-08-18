return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                cmake = { "gersemi" },
                make = { "mbake" },

                cpp = { "clang-format" },
                markdown = { "markdownlint" },
            }
        })

        -- keybindings
        vim.keymap.set({ "n", "v" }, "<M-S-f>", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500
            })
        end, {
            desc = "Format file or range (in visual mode)"
        })
    end
}
