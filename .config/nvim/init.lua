-- leader key
vim.g.mapleader = ' '

-- line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2

-- indent
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- clipboard
vim.o.clipboard = "unnamedplus"

-- splits
vim.o.splitright = true

-- windows
vim.o.winborder = "rounded"

-- sign column
vim.o.signcolumn = "yes"

-- swap files
vim.o.swapfile = false

-- keybinds
vim.keymap.set('n', "<M-S-f>", vim.lsp.buf.format, { desc = "Format current buffer" })
vim.keymap.set('n', "<leader>ca", vim.lsp.buf.code_action, { desc = "Show available code actions" })
vim.keymap.set('n', "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })

vim.keymap.set('n', "<C-h>", "<C-w>h", { desc = "Move to left window", remap = true })
vim.keymap.set('n', "<C-j>", "<C-w>j", { desc = "Move to bottom window", remap = true })
vim.keymap.set('n', "<C-k>", "<C-w>k", { desc = "Move to top window", remap = true })
vim.keymap.set('n', "<C-l>", "<C-w>l", { desc = "Move to right window", remap = true })

vim.keymap.set('v', '<', "<gv", { desc = "Indent left and keep selection highlighted" })
vim.keymap.set('v', '>', ">gv", { desc = "Indent right and keep selection highlighted" })

vim.keymap.set({ 'i', 'n', 's' }, "<esc>", function()
    vim.cmd("noh")
    return "<esc>"
end, { expr = true, desc = "Escape clears hlsearch" })

-- plugins
vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim", },
    { src = "https://github.com/wakatime/vim-wakatime", },
    { src = "https://github.com/neovim/nvim-lspconfig", },
    { src = "https://github.com/kylechui/nvim-surround", },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://git.sr.ht/~whynothugo/lsp_lines.nvim", },
    { src = "https://github.com/nvim-lua/plenary.nvim", },
    { src = "https://github.com/folke/todo-comments.nvim", },
    { src = "https://github.com/echasnovski/mini.pairs", },
    { src = "https://github.com/numToStr/Comment.nvim", },
    { src = "https://github.com/lewis6991/gitsigns.nvim", },
})

-- color scheme
vim.cmd("colorscheme tokyonight-night")

-- lsp
vim.lsp.enable({
    "lua_ls",
    "clangd",
})
vim.lsp.config("lua_ls", { settings = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("", true), } } } })


require("oil").setup({ view_options = { show_hidden = true } })
vim.keymap.set('n', "<C-n>", "<CMD>Oil --float<CR>", { desc = "Open Oil" })

require("nvim-surround").setup()
require("lsp_lines").setup()
vim.diagnostic.config({ virtual_text = false, virtual_lines = true, })
require("mini.pairs").setup()
require("Comment").setup({
    toggler = {
        ---Line-comment toggle keymap
        line = '<C-/>',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = '<C-/>',
    },
})
require("gitsigns").setup({
    -- original symbols
    -- signs                        = {
    --     add          = { text = '┃' },
    --     change       = { text = '┃' },
    --     delete       = { text = '_' },
    --     topdelete    = { text = '‾' },
    --     changedelete = { text = '~' },
    --     untracked    = { text = '┆' },
    -- },
    -- signs_staged                 = {
    --     add          = { text = '┃' },
    --     change       = { text = '┃' },
    --     delete       = { text = '_' },
    --     topdelete    = { text = '‾' },
    --     changedelete = { text = '~' },
    --     untracked    = { text = '┆' },
    -- },
    -- ascii symbols
    signs                        = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '-' },
        topdelete    = { text = '^' },
        changedelete = { text = '%' },
        untracked    = { text = '?' },
    },
    signs_staged                 = {
        add          = { text = 'A' },
        change       = { text = 'M' },
        delete       = { text = 'D' },
        topdelete    = { text = 'T' },
        changedelete = { text = 'C' },
        untracked    = { text = 'U' },
    },
    signs_staged_enable          = true,
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
        follow_files = true
    },
    auto_attach                  = true,
    attach_to_untracked          = false,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
        -- Options passed to nvim_open_win
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    on_attach                    = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)
        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('n', '<leader>hS', gitsigns.stage_buffer)
        -- map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>hd', gitsigns.diffthis)
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        -- map('n', '<leader>td', gitsigns.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
})

-- api
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#c4a7e7" })
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    callback = function()
        vim.highlight.on_yank()
    end,
})

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
