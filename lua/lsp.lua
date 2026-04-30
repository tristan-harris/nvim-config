-- https://xnacly.me/posts/2025/neovim-lsp-changes/

-- the configurations below are applied along with the built-in ones
-- provided by stock Neovim, as well as the ones provided by
-- nvim-lspconfig

-- find the names and configurations of the language server at https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

local lsps = {
    { "bashls" },
    { "clangd" },
    -- { "gdscript", { cmd = vim.lsp.rpc.connect("172.29.208.1", 6005) } },
    { "gdscript" },
    {
        "lua_ls",
        {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim", "mp" }, -- for Neovim config
                    },
                },
            },
        },
    },
}

for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end
