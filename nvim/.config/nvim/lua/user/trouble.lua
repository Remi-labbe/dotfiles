local Remap = require("user.keymaps.setup")
local nnoremap = Remap.nnoremap

local trouble_ok, trouble = pcall(require, "trouble")
if not trouble_ok then
    return
end

trouble.setup()

-- Open Trouble DiagList
nnoremap("<leader>q", "<cmd>TroubleToggle<CR>")
