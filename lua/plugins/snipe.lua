return {
    "leath-dub/snipe.nvim",
    keys = {
        {
            "gb",
            function()
                require("snipe").open_buffer_menu()
            end,
            desc = "Snipe buffer menu",
        },
    },
    opts = {
        ui = {
            position = "center",
            buffer_format = { "icon", "  ", "directory", "/", "filename" },
        },
    },
}
