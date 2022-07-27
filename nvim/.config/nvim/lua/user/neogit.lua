local Remap = require("user.keymaps.setup")
local nnoremap = Remap.nnoremap

local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
    return
end

neogit.setup{}

nnoremap("<leader>ng", neogit.open)
