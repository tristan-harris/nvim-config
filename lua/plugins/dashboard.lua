local logo = [[
███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
]]

-- https://youtu.be/9n1dtmzqnCU
local subHeader = "No more mouse, no more mice, no more traps."

logo = logo .. "\n" .. subHeader .. "\n\n"

-- apply upper margin proportional to window height
local paddingAmount = math.ceil(vim.api.nvim_win_get_height(0) * 0.2)
logo = string.rep("\n", paddingAmount) .. logo

return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
        local opts = {
            theme = "doom",
            config = {
                header = vim.split(logo, "\n"),
                -- stylua: ignore
                center = {
                    { action = "ene | startinsert",                                     desc = " New file",        icon = " ", key = "n" },
                    { action = "Telescope find_files",                                  desc = " Find file",       icon = " ", key = "p" },
                    { action = "Telescope oldfiles",                                    desc = " Recent files",    icon = "󰥔 ", key = "r" },
                    { action = "Telescope live_grep",                                   desc = " Find text",       icon = " ", key = "g" },
                    { action = "Telescope help_tags",                                   desc = " Find help",       icon = " ", key = "h" },
                    { action = "cd ~/.config/nvim | Telescope find_files",              desc = " Config",          icon = " ", key = "c" },
                    { action = 'lua require("persistence").load({last=true})',          desc = " Restore Session", icon = " ", key = "s" },
                    { action = "Lazy",                                                  desc = " Lazy",            icon = " ", key = "l" },
                    { action = "Mason",                                                 desc = " Mason",           icon = " ", key = "m" },
                    { action = "qa",                                                    desc = " Quit",            icon = " ", key = "q" },
                },

                -- -- Shortcut for searching your neovim configuration files
                -- vim.keymap.set('n', '<leader>sn', function()
                -- builtin.find_files { cwd = vim.fn.stdpath 'config' }
                -- end, { desc = '[S]earch [N]eovim files' })

                footer = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    return {
                        "󱐋 Neovim loaded "
                            .. stats.loaded
                            .. "/"
                            .. stats.count
                            .. " plugins in "
                            .. ms
                            .. "ms 󱐋",
                    }
                end,
            },
        }

        for _, button in ipairs(opts.config.center) do
            button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
            button.key_format = "  %s"
        end

        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "DashboardLoaded",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        return opts
    end,
}
