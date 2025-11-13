return {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    init = function()
        require("nvim-highlight-colors").turnOff()
    end,
}
