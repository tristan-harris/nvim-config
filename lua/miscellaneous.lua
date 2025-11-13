local function clean()
    vim.cmd([[retab]]) -- swap tabs with spaces
    vim.cmd([[keeppatterns %s/\ *$//]]) -- delete trailing whitespace (do not add substitution to search history)
end

vim.api.nvim_create_user_command("Clean", clean, { desc = "Remove tabs and unnecessary spaces" })

----------------------------------------------------------------------------------------------------

-- meant to be alternative to folke todo plugin

-- -- relies on https://github.com/stsewd/tree-sitter-comment
--
-- local function make_hl_bold(group)
--     local hl = vim.api.nvim_get_hl(0, { name = group })
--     hl.bold = true
--     vim.api.nvim_set_hl(0, group, hl)
-- end
--
-- local types = { "todo", "warning", "error", "note" }
--
-- for _, value in ipairs(types) do
--     make_hl_bold("@comment." .. value)
-- end
