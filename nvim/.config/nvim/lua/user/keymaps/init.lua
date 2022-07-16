local Remap = require("user.keymaps.setup")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
-- local inoremap = Remap.inoremap
-- local xnoremap = Remap.xnoremap
-- local nmap = Remap.nmap

nnoremap("<leader>e", ":Ex<CR>")

-- Move line up and down
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- indent faster
vnoremap(">", ">gv")
vnoremap("<", "<gv")

-- TrueZen Mode
nnoremap("<leader>tz", ":TZAtaraxis<CR>")

require("user.keymaps.telescope")
