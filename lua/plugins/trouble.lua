return {
    "folke/trouble.nvim",
    opts = {
        focus = true,
    },
    cmd = "Trouble",
    keys = {
        { "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[b]uffer diagnostics" },
        { "<leader>tp", "<cmd>Trouble diagnostics toggle<cr>", desc = "[p]roject diagnostics" },
        { "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "[s]ymbols" },
        { "grr", "<cmd>Trouble lsp_references<cr>", desc = "[r]eferences" },
    },
}
