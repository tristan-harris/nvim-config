return {
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    opts = {
        keymap = {
            preset = "default",
            ["<M-enter>"] = { "accept" },
        },

        appearance = {
            nerd_font_variant = "mono",
        },

        completion = {
            -- menu = { border = "single" },
            documentation = { auto_show = false, auto_show_delay_ms = 500 },
        },

        sources = {
            default = { "lsp", "path", "snippets" },
        },
        fuzzy = { implementation = "lua" },

        -- Shows a signature help window while you type arguments for a function
        signature = { enabled = false },
    },
}
