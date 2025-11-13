return {
    "tristan-harris/bee.nvim",
    dev = true,
    keys = {
        {
            "<leader>bb",
            function()
                require("bee").summon(2)
            end,
            mode = "n",
            desc = "Summon [b]ee",
        },
        {
            "<leader>bh",
            function()
                require("bee").fly_home()
            end,
            mode = "n",
            desc = "Send bee [h]ome",
        }, -- h for home/hive
        {
            "<leader>ba",
            function()
                require("bee").all_fly_home()
            end,
            mode = "n",
            desc = "Send [a]ll bees home",
        },
    },
}
