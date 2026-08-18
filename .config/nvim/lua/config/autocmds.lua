local api = vim.api

-- highlight on yank
api.nvim_set_hl(0, "IncSearch", { bg = "#c4a7e7" })
api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- autocomplete
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Automatically expand autocomplete (ctrl+x+o)",
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
vim.cmd("set completeopt+=noselect")
