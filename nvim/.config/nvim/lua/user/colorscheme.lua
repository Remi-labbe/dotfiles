vim.cmd [[
try
  colorscheme gruvbox
  set background=dark
  highlight ColorColumn ctermbg=0 guibg=grey
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
