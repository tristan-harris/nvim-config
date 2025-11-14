return {
    "mrjones2014/smart-splits.nvim",
    config = function()
        vim.keymap.set({"n", "i"}, "<C-A-h>", require("smart-splits").resize_left)
        vim.keymap.set({"n", "i"}, "<C-A-j>", require("smart-splits").resize_down)
        vim.keymap.set({"n", "i"}, "<C-A-k>", require("smart-splits").resize_up)
        vim.keymap.set({"n", "i"}, "<C-A-l>", require("smart-splits").resize_right)

        -- moving between splits
        vim.keymap.set({"n", "i"}, "<A-h>", require("smart-splits").move_cursor_left)
        vim.keymap.set({"n", "i"}, "<A-j>", require("smart-splits").move_cursor_down)
        vim.keymap.set({"n", "i"}, "<A-k>", require("smart-splits").move_cursor_up)
        vim.keymap.set({"n", "i"}, "<A-l>", require("smart-splits").move_cursor_right)
        vim.keymap.set({"n", "i"}, "<A-\\>", require("smart-splits").move_cursor_previous)

        -- -- swapping buffers between windows
        -- vim.keymap.set({"n", "i"}, "<leader><leader>h", require("smart-splits").swap_buf_left)
        -- vim.keymap.set({"n", "i"}, "<leader><leader>j", require("smart-splits").swap_buf_down)
        -- vim.keymap.set({"n", "i"}, "<leader><leader>k", require("smart-splits").swap_buf_up)
        -- vim.keymap.set({"n", "i"}, "<leader><leader>l", require("smart-splits").swap_buf_right)
    end,
}
