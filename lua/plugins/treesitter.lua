-- https://github.com/nvim-treesitter/nvim-treesitter (new main branch)
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L884

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
        local parsers = {
            "bash",
            "c",
            "cpp",
            "diff",
            "html",
            "javascript",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "powershell",
            -- "python",
            "query",
            "sql",
            "toml",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "zsh",
        }
        require("nvim-treesitter").install(parsers)

        -- start Treesitter for listed languages
        vim.api.nvim_create_autocmd("FileType", {
            pattern = parsers,
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
