local kms = vim.keymap.set

local function toggleinccomand()
    if vim.opt.inccommand == "split" then
        vim.opt.inccommand = "nosplit"
    else
        vim.opt.inccommand = "split"
    end
end

----------------------------------------------------------------------------------------------------

-- move to window using the <ctrl> hjkl keys
-- kms('n', '<C-h>', '<C-w>h',                                                                             {desc = 'Go to left window',  remap = true})
-- kms('n', '<C-j>', '<C-w>j',                                                                             {desc = 'Go to lower window', remap = true})
-- kms('n', '<C-k>', '<C-w>k',                                                                             {desc = 'Go to upper window', remap = true})
-- kms('n', '<C-l>', '<C-w>l',                                                                             {desc = 'Go to right window', remap = true})

-- move visual up and down (like alt+arrow key in vsc*de)
-- kms('v', 'J', ":move '>+1<CR>gv=gv")
-- kms('v', 'K', ":move '<-2<CR>gv=gv")

-- auto-centre after moving half-page up/down
-- kms('n', '<C-u>', '<C-u>zz')
-- kms('n', '<C-d>', '<C-d>zz')

kms("i", "<C-l>", "<C-o>$", { desc = "Move cursor to end of line" })

-- keep cursor in same place after pressing 'J' (uses 'z' mark)
kms("n", "J", "mzJ`z", { desc = "Preserve position of cursor after join" })

-- shorten '+y to <leader>y
kms({ "n", "v" }, "<leader>y", '"+y', { desc = "[y]ank to CLIPBOARD" })
kms("n", "<leader>Y", '"+y$', { desc = "[Y]ank to CLIPBOARD" })

-- delete to black hole! (doesn't affect other registers)
kms({ "n", "v" }, "<leader>d", '"_d', { desc = '[d]elete to "_' })
kms({ "n", "v" }, "<leader>D", '"+d', { desc = "[D]elete to CLIPBOARD" })

kms("n", "<esc>", function()
    if vim.snippet.active() then
        vim.snippet.stop()
    elseif vim.v.hlsearch then
        vim.cmd("nohlsearch")
    end
end, { desc = "Exit snippet/Clear highlight search" })

kms("n", "<C-s>", "<cmd>w<cr><esc>", { desc = "[s]ave file the normie way" })

-- :only shortcut
kms("n", "<leader>o", "<cmd>only<cr><esc>", { desc = "Close [o]ther windows" })

kms("i", "<C-z>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "Fix last spelling mistake" })

-- user interface
kms("n", "<leader>uC", require("telescope.builtin").colorscheme, { desc = "Choose [C]olor scheme" })
kms("n", "<leader>uD", "<cmd>Dashboard<cr><esc>", { desc = "Goto   [D]ashboard" })
kms("n", "<leader>uc", "<cmd>let &conceallevel = 2 - &conceallevel<cr><esc>", { desc = "Toggle [c]onceal" })
kms("n", "<leader>ui", toggleinccomand, { desc = "Toggle [i]nccommand" })
kms("n", "<leader>ul", "<cmd>HighlightColors Toggle<cr><esc>", { desc = "Toggle co[l]or highlighting" })
kms("n", "<leader>uL", "<cmd>set cursorline!<cr><esc>", { desc = "Toggle cursor [L]ine" })
kms("n", "<leader>ur", "<cmd>set relativenumber!<cr><esc>", { desc = "Toggle [r]elative number" })
kms("n", "<leader>us", "<cmd>set spell!<cr><esc>", { desc = "Toggle [s]pell" })
kms("n", "<leader>uw", "<cmd>set wrap!<cr><esc>", { desc = "Toggle [w]rap" })

kms("n", "<leader>ud", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle [d]iagnostics" })

kms("n", "<leader>uh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle [h]ints" })

kms("n", "<leader>uv", function()
    vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end, { desc = "Toggle [v]irtual lines" })

kms("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--- buffer
-- kset(map('<C-w>Q', ex('bdelete'))),
-- next & previous buffer
-- kms('n', '<S-Tab>', '<cmd>bprevious<cr><esc>', {desc = 'Previous buffer'})
-- kms('n', '<Tab>', '<cmd>bnext<cr><esc>', {desc = 'Next buffer'})
-- kset(map('<Tab>', ex('bnext'))),
