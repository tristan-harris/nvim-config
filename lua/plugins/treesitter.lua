-- based on lazyvim config https://www.lazyvim.org/plugins/treesitter

return {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "VeryLazy" },
    init = function(plugin)
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            config = function()
                -- when in diff mode, we want to use the default vim text objects c & C instead of the treesitter ones.
                local move = require("nvim-treesitter.textobjects.move")
                local configs = require("nvim-treesitter.configs")
                for name, fn in pairs(move) do
                    if name:find("goto") == 1 then
                        move[name] = function(q, ...)
                            if vim.wo.diff then
                                local config = configs.get_module("textobjects.move")[name]
                                for key, query in pairs(config or {}) do
                                    if q == query and key:find("[%]%[][cC]") then
                                        vim.cmd("normal! " .. key)
                                        return
                                    end
                                end
                            end
                            return fn(q, ...)
                        end
                    end
                end
            end,
        },
        -- { "nvim-treesitter/nvim-treesitter-context" }
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },

    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            "bash",
            "c",
            "diff",
            "html",
            "json",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "sql",
            "toml",
            "vim",
            "vimdoc",
            "yaml",
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = { query = "@function.outer", desc = "function" },
                    ["if"] = { query = "@function.inner", desc = "function" },
                    ["ac"] = { query = "@class.outer", desc = "class" },
                    ["ic"] = { query = "@class.inner", desc = "class" },
                },
                include_surrounding_whitespace = true,
            },
            move = {
                enable = true,
                goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
                    ["[a"] = "@parameter.inner",
                },
                goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
            },
        },
    },

    config = function(_, opts)
        if type(opts.ensure_installed) == "table" then
            local added = {}
            opts.ensure_installed = vim.tbl_filter(function(lang)
                if added[lang] then
                    return false
                end
                added[lang] = true
                return true
            end, opts.ensure_installed)
        end
        require("nvim-treesitter.configs").setup(opts)

        -- to render 'csharp' code blocks in markdown (not just 'cs')
        vim.treesitter.language.register("c_sharp", "csharp")
    end,
}
