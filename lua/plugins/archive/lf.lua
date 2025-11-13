return {
    "lmburns/lf.nvim",
    config = function()
        -- This feature will not work if the plugin is lazy-loaded
        vim.g.lf_netrw = 1

        require("lf").setup({
            winblend = 0,
            escape_quit = false,
            border = "single",
        })

        vim.keymap.set("n", "<M-o>", "<Cmd>Lf<CR>")
    end,
    dependencies = { "akinsho/toggleterm.nvim" },
}
