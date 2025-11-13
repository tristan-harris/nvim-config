local python_venv_table = {
    function()
        local conda_env = os.getenv("CONDA_DEFAULT_ENV")
        local venv_path = os.getenv("VIRTUAL_ENV")

        if venv_path ~= nil then
            local venv_name = vim.fn.fnamemodify(venv_path, ":t")
            return string.format("(%s)", venv_name)
        end
        if conda_env ~= nil then
            return string.format("(%s)", conda_env)
        end
        return ""
    end,
    cond = function()
        return vim.bo.filetype == "python"
    end,
    padding = { right = 0 },
}

return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        -- dependencies = {
        --     {
        --         'linrongbin16/lsp-progress.nvim',
        --         config = function()
        --             require('lsp-progress').setup()
        --             vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        --             vim.api.nvim_create_autocmd("User", {
        --                 group = "lualine_augroup",
        --                 pattern = "LspProgressStatusUpdated",
        --                 callback = require("lualine").refresh,
        --             })
        --         end
        --     }
        -- },
        opts = {
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = " ", right = " " },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = { "dashboard" },
                    tabline = { "dashboard" },
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = false,
                globalstatus = false,
                refresh = {
                    statusline = 50,
                    tabline = 50,
                    winbar = 200,
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {
                    { "filename" },
                    --     {
                    --     function()
                    --         return require('lsp-progress').progress()
                    --     end,
                    -- }
                },
                lualine_x = {
                    python_venv_table,
                    {
                        "filetype",
                        colored = false,
                        padding = { left = 0, right = 1 },
                    },
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            -- tabline = {
            --     lualine_a = {{
            --         "tabs",
            --         section_separators = { left = "▌", right = "▌" },
            --         tab_max_length = 120,
            --         max_length = function() return vim.o.columns end,
            --         mode = 1,
            --         path = 0,
            --     }},
            --     lualine_b = {},
            --     lualine_c = {},
            --     lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = {}
            -- },
            winbar = {},
            inactive_winbar = {},
            extensions = { "lazy", "man", "mason", "neo-tree", "trouble" },
        },
    },
}
