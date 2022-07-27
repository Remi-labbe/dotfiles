local tools_ok, _ = pcall(require, "rust-tools")
if not tools_ok then
    return
end

require("user.dap")

local Remap = require("user.keymaps.setup")
local nnoremap = Remap.nnoremap
nnoremap("<leader>rd", require "rust-tools.debuggables".debuggables)
nnoremap("<leader>rr", require "rust-tools.runnables".runnables)
