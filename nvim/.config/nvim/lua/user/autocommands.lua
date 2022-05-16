vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end
  augroup _asm
    autocmd!
    autocmd FileType asm setlocal noexpandtab
  augroup end
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
  augroup end
  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
  augroup end
  fun! StripTrailingWhitespace()
      if exists('b:noStripWhitespace')
          return
      endif
      let l:save = winsaveview()
      keeppatterns %s/\s\+$//e
      call winrestview(l:save)
  endfun
  augroup _trimtrailingwhitespaces
    autocmd!
    autocmd FileType markdown let b:noStripWhitespace=1
    autocmd BufWritePre * call StripTrailingWhitespace()
  augroup end
  augroup _nvimtree
    autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
  augroup end
]]
