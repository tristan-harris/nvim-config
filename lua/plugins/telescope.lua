return { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { -- If encountering errors, see telescope-fzf-native README for install instructions
            "nvim-telescope/telescope-fzf-native.nvim",

            build = "make",

            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        "nvim-telescope/telescope-ui-select.nvim",
        "debugloop/telescope-undo.nvim",
    },
    config = function()
        local open_with_trouble = require("trouble.sources.telescope").open

        require("telescope").setup({
            defaults = {
                borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                preview = { msg_bg_fillchar = " " }, -- removes harsh-looking slashes from binary file preview
                mappings = {
                    i = {
                        ["<c-enter>"] = "to_fuzzy_refine",
                        ["<c-t>"] = open_with_trouble,
                    },
                    n = {
                        ["<c-t>"] = open_with_trouble,
                    },
                },
            },
            -- pickers = { },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        })

        -- Enable telescope extensions, if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")
        pcall(require("telescope").load_extension, "telescope-undo")

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffer" })
        vim.keymap.set("n", "<leader>fG", builtin.git_files, { desc = "Find [G]it file" })
        vim.keymap.set("n", "<leader>fR", builtin.resume, { desc = "Find [R]esume" })
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find [d]iagnostics" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[g]rep files" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find [h]elp" })
        vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Find [j]ump" })
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find [k]eymap" })
        vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Find [m]ark" })
        vim.keymap.set("n", "<leader>fp", builtin.find_files, { desc = "Find [p]roject file" })
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find [r]ecent file" })
        vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find document [s]ymbols" })
        vim.keymap.set("n", "<leader>ft", builtin.builtin, { desc = "Find [t]elescope builtin" })
        vim.keymap.set("n", "<leader>fT", "<cmd>TodoTelescope<cr>", { desc = "Find [T]odos" })
        vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "Find [u]ndo" })
        vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find [w]ord (cursor)" })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set("n", "<leader>/", function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                previewer = false,
            }))
        end, { desc = "[/] Fuzzily search in current buffer" })

        -- Also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set("n", "<leader>f/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end, { desc = "Find [/] in open files" })

        -- Shortcut for searching your neovim configuration files
        vim.keymap.set("n", "<leader>fc", function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "Find [c]onfig file" })
    end,
}
