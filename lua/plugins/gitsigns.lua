return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            watch_gitdir = {
                follow_files = true,
            },
            auto_attach = true,
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map("n", "]h", function()
                    gitsigns.nav_hunk("next")
                end, { desc = "Next [h]unk" })
                map("n", "[h", function()
                    gitsigns.nav_hunk("prev")
                end, { desc = "Prev [h]unk" })

                map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "toggle [s]tage hunk " })
                map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[r]eset hunk" })
                map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[p]review hunk" })
                map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "preview hunk [i]nline" })
            end,
            preview_config = { border = "single" },
        })
    end,
}
