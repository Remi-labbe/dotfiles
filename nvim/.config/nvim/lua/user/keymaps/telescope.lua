local Remap = require("user.keymaps.setup")
local nnoremap = Remap.nnoremap

nnoremap("<Leader>pf", function()
    require('telescope.builtin').find_files()
end)

nnoremap("<Leader>ps", function()
    require('telescope.builtin').live_grep()
end)
