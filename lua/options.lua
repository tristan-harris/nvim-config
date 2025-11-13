-- general
vim.opt.autowrite = true -- automatically write when switching to a different buffer
vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
vim.opt.cursorline = true
vim.opt.linebreak = true -- do not split words when wrapping
vim.opt.list = true -- show some invisible characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true
vim.opt.ruler = false -- annoying numbers at the bottom right
vim.opt.scrolloff = 5 -- lines above/below cursor when scrolling (off=offset)
vim.opt.showmode = false -- handled by lualine
vim.opt.signcolumn = "yes"
vim.opt.spell = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true -- saves undos to file (at `undodir`)
vim.opt.undolevels = 1000
vim.opt.updatetime = 1000 -- after x ms nothing is typed, swap file written to disk
vim.opt.wrap = false

-- fold
-- https://redlib.catsarch.com/r/neovim/comments/1jmqd7t/sorry_ufo_these_7_lines_replaced_you/
vim.opt.fillchars:append({ fold = " " })
vim.opt.foldcolumn = "0"
vim.opt.foldenable = true
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- prefer LSP folding if client supports it
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr" -- default to treesitter folding
vim.opt.foldtext = ""

-- case
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- overrides ignore case when capital letters, \c or \C are used

-- tab configuration
vim.opt.expandtab = true -- convert TABs to spaces
vim.opt.shiftround = true -- round indent to multiple of 'shiftwidth'
vim.opt.shiftwidth = 4 -- number of spaces indented when reindent operations (>> and <<) are used
vim.opt.smarttab = true -- enable intelligent tabbing and spacing for indentation and alignment
vim.opt.softtabstop = 4 -- number of spaces in TAB when editing
vim.opt.tabstop = 4 -- number of visual spaces per TAB

-- vim.opt.iskeyword:remove('_')           -- treat '_' as not being part of a word

-- remove 'How-to disable mouse' and emtpy lines in mouse popup
vim.cmd([[aunmenu PopUp.How-to\ disable\ mouse]])
vim.cmd([[aunmenu PopUp.-1-]])
vim.cmd([[aunmenu PopUp.-2-]])

-- prevents treesitter syntax highlighting flickering issue (temporary fix)
-- https://www.reddit.com/r/neovim/comments/1jtz99h/treesitter_highlight_flickering/
vim.g._ts_force_sync_parsing = true
