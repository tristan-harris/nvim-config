return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = {
        "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Notes/*.md",
        "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Notes/*.md",
    },

    opts = {
        completion = {
            nvim_cmp = false,
            blink = true,
            min_chars = 2,
        },
        frontmatter = {
            enabled = false,
        },
        ui = {
            enable = false,
        },
        workspaces = {
            {
                name = "notes",
                path = "~/Documents/Notes",
            },
        },
        statusline = {
            enabled = false,
        },
        legacy_commands = false,
        footer = {
            enabled = false,
        },
        checkbox = {
            order = { " ", "x" },
        },
    },
}
