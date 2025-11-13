vim.diagnostic.config({
    severity_sort = true,
    float = { source = "if_many" },
    underline = { severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN } },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    },
    -- virtual_text = {
    --     severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
    --     current_line = true,
    --     source = "if_many",
    --     spacing = 1,
    --     prefix = function(diagnostic)
    --         local icons = {
    --             [vim.diagnostic.severity.ERROR] = "󰅚 ",
    --             [vim.diagnostic.severity.WARN]  = "󰀪 ",
    --             [vim.diagnostic.severity.INFO]  = "󰋽 ",
    --             [vim.diagnostic.severity.HINT]  = "󰌶 ",
    --         }
    --         return icons[diagnostic.severity]
    --     end,
    -- },
})
