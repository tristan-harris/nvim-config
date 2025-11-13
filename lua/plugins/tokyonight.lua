return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    init = function()
        vim.cmd.colorscheme("tokyonight-night")
    end,
    config = function()
        require("tokyonight").setup({
            style = "night",
            styles = {
                comments = { italic = true },
                keywords = { italic = false },
            },
            sidebar = { "qf" },
        })
    end,
}
