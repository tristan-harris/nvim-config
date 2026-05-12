local function clean()
    vim.cmd([[retab]]) -- swap tabs with spaces
    vim.cmd([[keeppatterns %s/\ *$//]]) -- delete trailing whitespace (do not add substitution to search history)
end

vim.api.nvim_create_user_command("Clean", clean, { desc = "Remove tabs and unnecessary spaces" })

vim.api.nvim_create_user_command("SortWords", function(opts)
    local ignore_case = opts.args == "i"
    local line = vim.api.nvim_get_current_line()
    local words = vim.split(line, "%s+", { trimempty = true })

    table.sort(words, function(a, b)
        if ignore_case then
            return a:lower() < b:lower()
        end

        return a < b
    end)

    vim.api.nvim_set_current_line(table.concat(words, " "))
end, { nargs = "?" })
