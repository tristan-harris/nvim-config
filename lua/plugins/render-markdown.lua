return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "md" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
        latex = { enabled = false },
        -- log_level = "debug",
        heading = {
            icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
            signs = {},
            backgrounds = { "DiffAdd", "DiffChange" },
        },
        code = {
            style = "normal",
            border = "thin",
        },
        dash = {
            icon = "━", -- https://www.w3.org/TR/xml-entity-names/025.html
            highlight = "Comment",
        },
        link = {
            custom = {
                -- the "%" in the lua patterns escapes the "."
                atlassian = { pattern = "atlassian%.com", icon = "󰠄 " },
                arch = { pattern = "archlinux%.org", icon = " " },
                bitcoinwiki = { pattern = "en%.bitcoin%.it", icon = "󰠓 " },
                debianwiki = { pattern = "wiki%.debian%.org", icon = " " },
                fourchan = { pattern = "4chan%.org", icon = "󰠖 " },
                gentoo = { pattern = "wiki%.installgentoo%.com", icon = "󰠖 " }, -- technolo/g/y board on 4chan
                godot = { pattern = "godotengine", icon = " " },
                onion = { pattern = "%.onion", icon = " " },
                python = { pattern = "python%.org", icon = " " },
                redlib = { pattern = "redlib", icon = "󰑍 " },
            },
        },
        inline_highlight = { -- text surrounded by double equals
            highlight = "DiffAdd",
        },
        callout = {
            declaration = { raw = "[!DECLARATION]", rendered = "󰗅 DECLARATION", highlight = "RenderMarkdownHint" }, -- custom callout
        },
        quote = {
            repeat_linebreak = true,
        },

        -- needed for nice looking block quotes
        -- https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki/BlockQuotes
        win_options = {
            showbreak = { default = "", rendered = "  " },
            breakindent = { default = false, rendered = true },
            breakindentopt = { default = "", rendered = "" },
        },
    },
    keys = {
        { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", mode = "n", desc = "Toggle [m]arkdown renderer" },
    },
}
