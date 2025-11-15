return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    config = function()
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        require("mason-lspconfig").setup({
            automatic_enable = { -- automatically enable all other LSP configs
                exclude = {
                    "ruff", -- not needed as LS
                },
            },
        })

        vim.lsp.config("clangd", {
            capabilities = {
                textDocument = {
                    completion = {
                        completionItem = {
                            snippetSupport = false, -- disable snippets from LS
                        },
                    },
                },
            },
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim", "mp" },
                    },
                },
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
                end

                map("gd", vim.lsp.buf.definition, "goto [d]efinition")

                map("gD", vim.lsp.buf.declaration, "goto [D]eclaration")

                --- add borders so that text is readable
                map("K", function()
                    vim.lsp.buf.hover({ border = "single" })
                end, "LSP Hover")

                vim.keymap.set("i", "<C-S>", function()
                    vim.lsp.buf.signature_help({ border = "single" })
                end, { desc = "Signature Help", buffer = event.buf })

                -- highlight instances of word under cursor
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })
    end,
}
