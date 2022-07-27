local Remap = require("user.keymaps.setup")
local nnoremap = Remap.nnoremap

local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
    return
end

-- Set breakpoints
nnoremap("<leader>db", dap.toggle_breakpoint)
nnoremap("<leader>dc", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)

-- Step through debug session
nnoremap("<F2>", dap.continue)
nnoremap("<F3>", dap.step_over)
nnoremap("<F4>", dap.step_into)
nnoremap("<F5>", dap.step_out)
