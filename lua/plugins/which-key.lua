return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "classic",
        delay = 1000,
        spec = {
            { "<leader>b", group = "[b]ee" },
            { "<leader>c", group = "[c]ode" },
            { "<leader>f", group = "[f]ind" },
            { "<leader>h", group = "[h]unk" },
            { "<leader>m", group = "[m]iscellaneous" },
            { "<leader>r", group = "[r]ename" },
            { "<leader>t", group = "[t]rouble" },
            { "<leader>u", group = "[u]ser Interface" },
            { "<leader>w", group = "[w]orkspace" },
        },
        sort = { "group", "order", "local", "alphanum", "mod", "lower", "icase" },
        icons = {
            rules = false,
        },
    },
}
