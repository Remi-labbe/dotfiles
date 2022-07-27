SCHEME = "tokyonight"

vim.g.gruvbox_invert_selection = '0'
vim.g.gruvbox_contrast_dark = "medium"
vim.g.tokyonight_style = "night"
vim.g.tokyonight_transparent = false

vim.opt.background = "dark"
local cmd_ok, _ = pcall(vim.cmd, "colorscheme " .. SCHEME)
if not cmd_ok then
    vim.notify("colorscheme " .. SCHEME .. " not found!")
    return
end

local colorizer_ok, colorizer = pcall(require, "colorizer")
if not colorizer_ok then
    return
end

colorizer.setup()

local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
    return
end


local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    colored = true,
    update_in_insert = false,
    always_visible = false,
}

local diff = {
    "diff",
    colored = false,
    symbols = { added = "+", modified = "~", removed = "-" }, -- changes diff symbols
    cond = hide_in_width
}

local filename = {
    "filename",
    file_status = true, -- Displays file status (readonly status, modified status)
    path = 1, -- 0: Just the filename
    -- 1: Relative path
    -- 2: Absolute path

    shorting_target = 30, -- Shortens path to leave 40 spaces in the window
    -- for other components. (terrible name, any suggestions?)
    symbols = {
        modified = ' [+]', -- Text to show when the file is modified.
        readonly = ' [RO]', -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
    }
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

local location = {
    "location",
    padding = 0,
}

lualine.setup({
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { branch, diff, diagnostics },
        lualine_c = { filename },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { location }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
})
