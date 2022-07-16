local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

local userGroup = augroup('UserCmds', {})

autocmd({ "BufWritePre" }, {
    group = userGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

usercmd("Format", "lua vim.lsp.buf.formatting()", {})
