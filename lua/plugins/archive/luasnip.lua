return {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    build = "make install_jsregexp",
    config = function()
        require("luasnip.loaders.from_vscode").load({
            -- paths = { vim.fn.stdpath("config") .. "/snippets" }
            paths = { "./snippets" },
        })
    end,
    opts = {},
}
