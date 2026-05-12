local extension = {
    eccs = "eccs",
    h = "c",
    log = "log",
}

local filename = {
    [".env"] = "config",
    [".envrc"] = "config",
    [".yamlfmt"] = "yaml",
}

vim.filetype.add({
    extension = extension,
    filename = filename,
})
