return {
    "stevearc/conform.nvim",
    lazy = true,
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            desc = "[f]ormat buffer",
        },
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                cs = { "csharpier" },
                javascript = { "prettier" },
                json = { "prettier" },
                lua = { "stylua" },
                python = { "ruff_format" },
                typescript = { "prettier" },
                vue = { "prettier" },
            },
            -- format_on_save = {
            --     async = true,
            --     lsp_format = "fallback",
            -- },
        })
    end,
}
