local map = vim.keymap.set

map('n', "<leader>ca", vim.lsp.buf.code_action, { desc = "Show available code actions" })
map('n', "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })

-- better moving up and down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- window navigation
map('n', "<C-h>", "<C-w>h", { desc = "Move to left window", remap = true })
map('n', "<C-j>", "<C-w>j", { desc = "Move to bottom window", remap = true })
map('n', "<C-k>", "<C-w>k", { desc = "Move to top window", remap = true })
map('n', "<C-l>", "<C-w>l", { desc = "Move to right window", remap = true })

-- better indenting
map('v', '<', "<gv", { desc = "Indent left and keep selection highlighted" })
map('v', '>', ">gv", { desc = "Indent right and keep selection highlighted" })

-- clear search highlighting
map({ 'i', 'n', 's' }, "<esc>", function()
    vim.cmd("noh")
    return "<esc>"
end, { expr = true, desc = "Escape clears hlsearch" })
