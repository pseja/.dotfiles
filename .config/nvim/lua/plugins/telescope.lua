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

        map('n', "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
        map('n', "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
        map('n', "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
        map('n', "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    end
}
