return {
    { -- Linting
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                -- python = { "pylint" },
                -- gdscript = { 'gdlint' },
            }

            -- Create autocommand which carries out the actual linting
            -- on the specified events.
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    -- Only run the linter in buffers that you can modify in order to
                    -- avoid superfluous noise, notably within the handy LSP pop-ups that
                    -- describe the hovered symbol using Markdown.
                    if vim.opt_local.modifiable:get() then
                        lint.try_lint()
                    end
                end,
            })

            -- vim.keymap.set("n", "<leader>l", function()
            --
            --     local is_visible = true
            --     -- lint.try_lint()
            --
            --     -- 1. Get the filetype of the current buffer
            --     local ft = vim.bo.filetype
            --
            --     -- 2. Get the linters assigned to that filetype
            --     local linters = lint.linters_by_ft[ft]
            --
            --     if not linters then
            --         print("No linters configured for filetype: " .. ft)
            --     else
            --         is_visible = not is_visible
            --         for _, linter_name in ipairs(linters) do
            --             local namespace = lint.get_namespace(linter_name)
            --             vim.diagnostic.config( { signs = is_visible, virtual_text = is_visible, underline = is_visible }, namespace)
            --         end
            --     end
            --
            -- end, { desc = "[l]int current file" })

            -- -- set pylint to work in virtualenv
            -- require("lint").linters.pylint.cmd = "python"

            -- -- require('lint').linters.pylint.args = {'-m', 'pylint'}
            -- require('lint').linters.pylint.args = { '-m', 'pylint', '-f', 'json', vim.api.nvim_buf_get_name(0) }
        end,
    },
}
