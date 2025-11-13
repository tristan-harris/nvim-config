local group = vim.api.nvim_create_augroup("MyAutoCommandGroup", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = "Highlight on yank",
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    group = group,
    pattern = "*",
    command = 'silent! normal! g`"zv',
    desc = "Return cursor to where it was last time closing the file",
})

-- do not add a comment leader after inserting line below existing comment
-- autocommand needed this option is overriden by many ftplugins
-- ENTER still works on a commented line (remove with -r)
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "*",
    command = "set formatoptions-=o",
    desc = "Override ftplugin configuration in regards to 'formatoptions'",
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = {
        "checkhealth",
        "fugitive*",
        "git",
        "gitsigns-blame",
        "grug-far",
        "help",
        "lspinfo",
        "man",
        "netrw",
        "notify",
        "qf",
        "query",
    },
    callback = function()
        vim.keymap.set("n", "q", vim.cmd.close, { desc = "Close the current buffer", buffer = true })
    end,
    desc = "Easily quit out of windows showing certain filetypes",
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = group,
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
    desc = "Auto create directory(s) when saving a file",
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    pattern = "Calendar.md",
    callback = function()
        local date_string = tostring(os.date("%d/%m/%Y %a"))
        vim.api.nvim_set_hl(0, "CurrentDateHighlightGroup", { link = "@markup.heading" })
        vim.fn.matchadd("CurrentDateHighlightGroup", date_string)
        vim.keymap.set("n", "<leader>mc", function()
            vim.fn.search(date_string, "w") -- capital 'W' to wrap search
            vim.cmd("normal! zz")
        end, { desc = "Goto [c]urrent day" })
    end,
    desc = "Highlight current day in calendar",
})

-- see also 'fold' section in options
-- https://redlib.catsarch.com/r/neovim/comments/1jmqd7t/sorry_ufo_these_7_lines_replaced_you/
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client ~= nil and client:supports_method("textDocument/foldingRange") then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "gdscript", -- Replace 'python' with your desired filetype
    callback = function()
        vim.b.did_ftplugin = 1 -- Prevent the built-in ftplugin from loading
    end,
})

-- ==========================================================================================================

-- turn off relative numbers in insert mode
-- vim.api.nvim_create_autocmd({ "VimEnter", "InsertLeave" }, {
--     group = group,
--     pattern = "*",
--     command = "set relativenumber",
-- })
-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--     group = group,
--     pattern = "*",
--     command = "set relativenumber!",
-- })

-- -- Copy text to clipboard using codeblock format ```{ft}{content}```
-- vim.api.nvim_create_user_command('CopyCodeBlock', function(opts)
--   local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)
--   local content = table.concat(lines, '\n')
--   local result = string.format('```%s\n%s\n```', vim.bo.filetype, content)
--   vim.fn.setreg('+', result)
--   vim.notify 'Text copied to clipboard'
-- end, { range = true })

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = {
--         "dashboard",
--         "neo-tree",
--     },
--     command = 'highlight clear EndOfBuffer', -- The waves do not roll here...
--     desc = "The waves roll once more",
-- })
