local function switch_source_header()
    local current_file = vim.api.nvim_buf_get_name(0)
    local file_basename = vim.fn.fnamemodify(current_file, ":t:r")
    local file_extension = vim.fn.fnamemodify(current_file, ":e")
    local corresponding_file

    if file_extension == "h" then
        corresponding_file = file_basename .. ".c"
    else
        corresponding_file = file_basename .. ".h"
    end

    local old_path = vim.opt.path:get()
    vim.opt.path = { "**" }
    vim.cmd("find " .. corresponding_file)
    vim.opt.path = old_path
end

vim.keymap.set("n", "<leader>cs", switch_source_header, { desc = "[s]witch between source/header" })
