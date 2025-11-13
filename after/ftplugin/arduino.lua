local compileCommand = "arduino-cli compile --no-color --libraries ~/.arduino15/libraries --fqbn arduino:avr:uno ."

local function createUploadCommand(opts)
    local ttyACM_number = opts.fargs[1] or 0 -- default ttyACM number to 0 if not given
    return "arduino-cli upload --no-color -p /dev/ttyACM" .. tostring(ttyACM_number) .. " --fqbn arduino:avr:uno ."
end

local function uploadSketch(opts)
    vim.cmd("!" .. createUploadCommand(opts))
end

local function buildSketch(opts)
    vim.cmd("!" .. compileCommand .. " && " .. createUploadCommand(opts))
end

-- https://neovim.io/doc/user/lua-guide.html#lua-guide-command
vim.api.nvim_create_user_command("ArduinoCompile", "!" .. compileCommand, { desc = "Compile Arduino Sketch" })
vim.api.nvim_create_user_command("ArduinoUpload", uploadSketch, { nargs = "?", desc = "Upload Arduino Sketch" })
vim.api.nvim_create_user_command(
    "ArduinoBuild",
    buildSketch,
    { nargs = "?", desc = "Compile and Upload Arduino Sketch" }
)

vim.opt.commentstring = "//%s"
