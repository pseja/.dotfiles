return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true)
                    }
                }
            }
        })

        vim.lsp.enable({
            "clangd",
            "lua_ls",
            "marksman",
        })
    end
}
