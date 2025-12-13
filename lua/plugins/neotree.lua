return {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    init = function()
        -- https://redlib.catsarch.com/r/neovim/comments/195mfz2/comment/kuvtqna
        vim.api.nvim_create_autocmd("BufEnter", {
            -- make a group to be able to delete it later
            group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
            callback = function()
                local f = vim.fn.expand("%:p")
                if vim.fn.isdirectory(f) ~= 0 then
                    vim.cmd("Neotree current dir=" .. f)
                    -- neo-tree is loaded now, delete the init autocmd
                    vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
                end
            end,
        })
    end,
    keys = {
        {
            "<C-n>",
            function()
                require("neo-tree.command").execute({
                    toggle = true,
                    position = "float",
                    dir = vim.loop.cwd(),
                    reveal = true,
                })
            end,
            mode = "n",
            desc = "[n]eoTree explorer",
        },
    },
    opts = {
        sources = { "filesystem" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
        sort_case_insensitive = true,
        filesystem = {
            hijack_netrw_behavior = "disabled", -- needed to work with init code above
            bind_to_cwd = false,
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
            window = {
                mappings = {
                    ["D"] = "delete",
                    ["d"] = "cut_to_clipboard",
                    ["u"] = "system_open",
                    ["zh"] = "toggle_hidden",
                    ["zp"] = "toggle_preview",
                },
            },
            filtered_items = {
                hide_by_pattern = {
                    -- Godot
                    "*.import",
                    "*.uid",
                    "*.tscn",
                },
            },
        },
        commands = {
            system_open = function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                vim.fn.jobstart({ "xdg-open", path }, { detach = true })
            end,
        },
        window = {
            -- mappings are overriden so they are like lf
            mappings = { -- mappings for all sources
                ["<C-k>"] = "prev_git_modified",
                ["<C-j>"] = "next_git_modified",
                ["<space>"] = "none",
                ["h"] = "close_node",
                ["H"] = "none",
                ["J"] = {
                    function()
                        vim.cmd("normal! 5j")
                    end,
                    desc = "jump_down",
                },
                ["K"] = {
                    function()
                        vim.cmd("normal! 5k")
                    end,
                    desc = "jump_up",
                },
                ["l"] = "open",
                ["P"] = { "toggle_preview", config = { use_float = false } }, -- override buggy floating preview
                ["Y"] = {
                    function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        vim.fn.setreg("+", path, "c")
                    end,
                    desc = "yank_path",
                    nowait = true,
                },
            },
            position = "float",
        },
        default_component_configs = {
            git_status = {
                symbols = {
                    -- change type (can tell by filename color instead)
                    added = "",
                    deleted = "",
                    modified = "",
                    renamed = "",
                    -- status type
                    -- untracked = "",
                    -- ignored   = "",
                    -- unstaged  = "󰄱",
                    -- staged    = "",
                    -- conflict  = "",
                    untracked = "",
                    ignored = "",
                    unstaged = "",
                    staged = "",
                    conflict = "",
                },
            },
            indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
        },
        popup_border_style = "single",
    },
}
