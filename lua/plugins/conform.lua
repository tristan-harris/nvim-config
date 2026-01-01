return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
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
            format_on_save = {
                timeout_ms = 500,
                -- async = true,
                lsp_format = "fallback",
            },
        })
    end,
}
