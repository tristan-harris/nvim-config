-- has the effect of removing the blue background from `` in markdown
vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { link = "@markup.environment" })

-- vim.opt.autowriteall    = true
vim.opt.wrap = true
-- vim.opt.textwidth       = 160 -- good for 'gqq' action (default 80)

-- don't enable spellcheck for hover documentation and other floating windows
if vim.bo.buftype ~= "nofile" then
    vim.opt_local.spell = true
end

-- =============================================================================

-- Highlight #todo/#TODO in notes
-- colors pulled from https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/storm.lua
vim.api.nvim_set_hl(0, "TodoHighlightGroup", { fg = "#1a1b26", bg = "#1abc9c", bold = true })
vim.fn.matchadd("TodoHighlightGroup", "#todo")
vim.fn.matchadd("TodoHighlightGroup", "#TODO")

-- =============================================================================

-- url needs to be surrounded in double quotes
local function filePaste(opts)
    if opts and opts.fargs[1] then
        local fileURL = opts.fargs[1]
        vim.fn.system("cd Assets && curl -OL " .. fileURL)

        local fileName = fileURL:gsub('"', "")

        -- remove characters from start to rightmost instance of / (including /)
        fileName = fileName:sub(fileURL:match(".*/()") - 1)

        local buf = vim.api.nvim_get_current_buf()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        -- insert the string at the current cursor position
        vim.api.nvim_buf_set_text(buf, row - 1, col, row - 1, col, { "[[file:Assets/" .. fileName .. "]]" })
    else
        print("Need to provide file URL")
    end
end

vim.api.nvim_create_user_command("PasteFile", filePaste, { desc = "Paste file (from URL) into markdown document" })

-- =============================================================================

local notes_directory = "~/Documents/Notes/"

local function directory_exists(path)
    return vim.fn.isdirectory(vim.fn.expand(path)) == 1
end

local function get_directories(path)
    local files = {}
    local scan = vim.loop.fs_scandir(path)

    while scan do
        local name, type = vim.loop.fs_scandir_next(scan)

        if not name then
            break
        end -- ends loop

        -- select directories only, excluding hidden ones
        if type == "directory" and not name:match("^%.") then
            table.insert(files, name)
        end
    end

    return files
end

local function notes(opts)
    local target_directory = notes_directory .. opts.args
    if directory_exists(target_directory) then
        vim.cmd("cd " .. target_directory)
        print("Moved to " .. opts.args)
    else
        print("Notes directoy " .. target_directory .. " does not exist")
    end
end

vim.api.nvim_create_user_command("Notes", notes, {
    nargs = 1,
    complete = function(_, _, _)
        return get_directories(vim.fn.expand(notes_directory))
    end,
    desc = "Jump to different notes directory",
})

-- =============================================================================

local function insertTitle(with_directory)
    local filename = vim.fn.fnamemodify(vim.fn.expand("%"), ":t")
    local title = "# " .. string.gsub(filename, ".md", "")
    local dir = vim.fn.fnamemodify(vim.fn.expand("%:p:h"), ":t")
    local result = title
    if with_directory then
        result = result .. " - " .. dir
    end
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { result })
end

vim.keymap.set("n", "<leader>mt", insertTitle, { desc = "Insert [t]itle" })
vim.keymap.set("n", "<leader>mT", function()
    insertTitle(true)
end, { desc = "Insert extended [T]itle" })

-- =============================================================================

vim.keymap.set("n", "<leader>mu", function()
    local text = "<" .. vim.fn.getreg("+") .. ">"
    vim.api.nvim_put({ text }, "c", false, false)
end, { desc = "Insert [u]rl" })

vim.keymap.set("n", "<leader>mq", function()
    local line = vim.api.nvim_get_current_line()
    if string.sub(line, 1, 2) == "> " then
        vim.api.nvim_set_current_line(string.sub(line, 3))
    else
        vim.api.nvim_set_current_line("> " .. line)
    end
end, { desc = "Toggle [q]uote" })

-- =============================================================================

local function capitaliseFirstLowercase()
    local line = vim.api.nvim_get_current_line()
    local position = string.find(line, "%l")

    if position then
        local char = string.sub(line, position, position)
        local capitalized_line = string.sub(line, 1, position - 1)
            .. string.upper(char)
            .. string.sub(line, position + 1)
        vim.api.nvim_set_current_line(capitalized_line)
    else
        print("No lowercase letter found on the current line.")
    end
end

vim.keymap.set("n", "<leader>m>", capitaliseFirstLowercase, { desc = "Capitalise first lower character" })

-- =============================================================================

local function toggleMarkdownBold()
    local word = vim.fn.expand("<cword>")
    local line = vim.api.nvim_get_current_line()

    -- match word boundaries for bold markdown
    local bold_pattern = "%*%*" .. word .. "%*%*"

    if string.find(line, bold_pattern) then
        -- remove bolding
        line = string.gsub(line, bold_pattern, word, 1)
        vim.api.nvim_set_current_line(line)
    else
        -- add bolding
        line = string.gsub(line, word, "**" .. word .. "**", 1)
        vim.api.nvim_set_current_line(line)
    end
end

vim.keymap.set("n", "<leader>mb", toggleMarkdownBold, { desc = "Toggle [b]old" })

-- =============================================================================

local function changeCurrentWorkingDirectory()
    vim.cmd([[cd %:p:h]])
    print(vim.fn.expand("%:p:h"))
end

vim.keymap.set("n", "<leader>md", changeCurrentWorkingDirectory, { desc = "Change current [d]irectory" })

-- =============================================================================

local function toggleCheckbox()
    local line = vim.api.nvim_get_current_line()
    local new_line

    if line:match("^%s*%- %[ %]") then
        new_line = line:gsub("%- %[ %]", "- [x]", 1)
    elseif line:match("^%s*%- %[x%]") then
        new_line = line:gsub("%- %[x%]", "- [ ]", 1)
    else
        new_line = "- [ ] " .. line
    end

    vim.api.nvim_set_current_line(new_line)
end

-- Set up autocmd for Markdown filetype
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        -- Buffer-local keymap only for markdown files
        vim.keymap.set("n", "<C-Space>", toggleCheckbox, { buffer = true, desc = "Toggle checkbox" })
    end,
})
