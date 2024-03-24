local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = "/bin/zsh",
  float_opts = {
    border = "single",
    winblend = 0,
  },
}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new {
  size = 15,
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "single",
  },
}

local toggle_lazygit = function()
  lazygit:toggle()
end

local Remap = require("user.keymaps.setup")
local nnoremap = Remap.nnoremap

nnoremap("<leader>lg", toggle_lazygit)
