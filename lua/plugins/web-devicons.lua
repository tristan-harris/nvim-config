return {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
        strict = true,
        override_by_extension = {
            ["cs"] = {
                icon = "󰌛",
                color = "#BB9AF7",
                name = "CSharp",
            },
            ["eccs"] = {
                icon = "󱁘",
                color = "#06af32",
                name = "ECCS",
            },
            ["gmi"] = {
                icon = "󰪁",
                color = "#4B3998",
                name = "gemtext",
            },
        },
    },
}
