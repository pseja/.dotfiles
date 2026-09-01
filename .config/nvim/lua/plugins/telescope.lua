return {
    "nvim-telescope/telescope.nvim",
    version = '*',
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install"
        }
    },
    config = function()
        require("telescope").load_extension("fzf")

        local map = vim.keymap.set
        local builtin = require("telescope.builtin")

        -- core search
        map('n', "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
        map('n', "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
        map('n', "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
        map('n', "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
        map('n', "<leader>fw", builtin.grep_string, { desc = "Grep the word under cursor" })

        -- lsp navigation
        map('n', "gd", builtin.lsp_definitions, { desc = "Go to definition" })
        map('n', "gr", builtin.lsp_references, { desc = "Go to references" })
        map('n', "gi", builtin.lsp_implementations, { desc = "Go to implementation" })
        map('n', "gy", builtin.lsp_type_definitions, { desc = "Go to type definition" })

        -- symbols
        map('n', "<leader>ds", builtin.lsp_document_symbols, { desc = "Document symbols (Classes, Functions, etc.)" })
        map('n', "<leader>ws", builtin.lsp_workspace_symbols, { desc = "Workspace symbols across the whole project" })
        map('n', "<leader>xd", builtin.diagnostics, { desc = "List workspace diagnostics" })

        -- utils
        map('n', "<leader>tr", builtin.resume, { desc = "Resume last Telescope picker" })
        map('n', "<leader>tk", builtin.keymaps, { desc = "Search active keymaps" })
        map('n', "<leader>gs", builtin.git_status, { desc = "Search changed files (git status)" })
    end
}
