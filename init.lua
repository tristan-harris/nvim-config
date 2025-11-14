-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("lazy").setup({
    -- THEME
    require("plugins.tokyonight"),

    -- DEPENDENCIES
    { "MunifTanjim/nui.nvim", lazy = true },
    { "nvim-lua/plenary.nvim", lazy = true },
    require("plugins.web-devicons"),

    -- CORE
    require("plugins.blink-cmp"),
    require("plugins.mason-lspconfig"),
    require("plugins.treesitter"),

    -- NAVIGATION
    require("plugins.neotree"),
    require("plugins.telescope"),
    require("plugins.snipe"),

    -- UI
    require("plugins.dashboard"),
    require("plugins.highlight-colors"),
    require("plugins.lualine"),
    require("plugins.neoscroll"),
    require("plugins.smart-splits"),
    require("plugins.todo-comments"),
    require("plugins.trouble"),
    require("plugins.which-key"),

    -- GIT
    require("plugins.gitsigns"),
    require("plugins.lazygit"),

    -- UTILITY
    require("plugins.autopairs"),
    require("plugins.conform"),
    require("plugins.grug-far"),
    require("plugins.nvim-lint"),
    require("plugins.persistence"),

    -- MARKDOWN
    require("plugins.obsidian-nvim"),
    require("plugins.render-markdown"),

    -- IMPORTANT
    -- require('plugins.bee'),
}, {
    dev = {
        path = "~/Programming/Lua/Neovim", -- where cloned plugins reside
    },
    install = {
        colorscheme = { "tokyonight-night" }, -- loads colorscheme before installing anything
    },
    rocks = {
        enabled = false,
    },
})

-- make background transparent (required for tmux)
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

-- set out of focus windows to terminal color scheme 'black' color
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#14151d" })
vim.api.nvim_set_hl(0, "CursorLineNC", { bg = "#14151d" })

require("autocommands")
require("diagnostics")
require("filetype")
require("keymaps")
require("miscellaneous")
require("options")
