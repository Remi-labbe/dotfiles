SCHEME = "kanagawa-wave"

--[[ require("gruvbox").setup({ ]]
--[[   undercurl = true, ]]
--[[   underline = true, ]]
--[[   bold = true, ]]
--[[   italic = { ]]
--[[     strings = true, ]]
--[[     comments = true, ]]
--[[     operators = false, ]]
--[[     folds = true, ]]
--[[   }, ]]
--[[   strikethrough = true, ]]
--[[   invert_selection = false, ]]
--[[   invert_signs = false, ]]
--[[   invert_tabline = false, ]]
--[[   invert_intend_guides = false, ]]
--[[   inverse = true,    -- invert background for search, diffs, statuslines and errors ]]
--[[   contrast = "hard", -- can be "hard", "soft" or empty string ]]
--[[   overrides = {}, ]]
--[[   dim_inactive = false, ]]
--[[   transparent_mode = false, ]]
--[[ }) ]]

--[[ vim.opt.background = "dark" ]]
local cmd_ok, _ = pcall(vim.cmd, "colorscheme " .. SCHEME)
if not cmd_ok then
  vim.notify("colorscheme " .. SCHEME .. " not found!")
  return
end

--[[ require('colorbuddy').colorscheme('gruvbuddy') ]]

-- TJ STUFF

--[[ local c = require("colorbuddy.color").colors ]]
--[[ local Group = require("colorbuddy.group").Group ]]
--[[ local g = require("colorbuddy.group").groups ]]
--[[ local s = require("colorbuddy.style").styles ]]
--[[]]
--[[ Group.new("GoTestSuccess", c.green, nil, s.bold) ]]
--[[ Group.new("GoTestFail", c.red, nil, s.bold) ]]

-- Group.new('Keyword', c.purple, nil, nil)

--[[ Group.new("TSPunctBracket", c.orange:light():light()) ]]
--[[]]
--[[ Group.new("StatuslineError1", c.red:light():light(), g.Statusline) ]]
--[[ Group.new("StatuslineError2", c.red:light(), g.Statusline) ]]
--[[ Group.new("StatuslineError3", c.red, g.Statusline) ]]
--[[ Group.new("StatuslineError3", c.red:dark(), g.Statusline) ]]
--[[ Group.new("StatuslineError3", c.red:dark():dark(), g.Statusline) ]]
--[[]]
--[[ Group.new("pythonTSType", c.red) ]]
--[[ Group.new("goTSType", g.Type.fg:dark(), nil, g.Type) ]]
--[[]]
--[[ Group.new("typescriptTSConstructor", g.pythonTSType) ]]
--[[ Group.new("typescriptTSProperty", c.blue) ]]

-- vim.cmd [[highlight WinSeparator guifg=#4e545c guibg=None]]
--[[ Group.new("WinSeparator", nil, nil) ]]

-- I don't think I like highlights for text
-- Group.new("LspReferenceText", nil, c.gray0:light(), s.bold)
-- Group.new("LspReferenceWrite", nil, c.gray0:light())

-- Group.new("TSKeyword", c.purple, nil, s.underline, c.blue)
-- Group.new("LuaFunctionCall", c.green, nil, s.underline + s.nocombine, g.TSKeyword.guisp)

--[[ Group.new("TSTitle", c.blue) ]]

-- TODO: It would be nice if we could only highlight
-- the text with characters or something like that...
-- but we'll have to stick to that for later.
--[[ Group.new("InjectedLanguage", nil, g.Normal.bg:dark()) ]]
--[[]]
--[[ Group.new("LspParameter", nil, nil, s.italic) ]]
--[[ Group.new("LspDeprecated", nil, nil, s.strikethrough) ]]

-- END TJ STUFF

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
  path = 4,           -- 0: Just the filename
  -- 1: Relative path
  -- 2: Absolute path

  shorting_target = 30, -- Shortens path to leave 40 spaces in the window
  -- for other components. (terrible name, any suggestions?)
  symbols = {
    modified = ' [+]',     -- Text to show when the file is modified.
    readonly = ' [RO]',    -- Text to show when the file is non-modifiable or readonly.
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

--[[ local builtin = require "el.builtin" ]]
--[[ local extensions = require "el.extensions" ]]
--[[ local sections = require "el.sections" ]]
--[[ local subscribe = require "el.subscribe" ]]
--[[ local lsp_statusline = require "el.plugins.lsp_status" ]]
--[[ local helper = require "el.helper" ]]
--[[ local diagnostic = require "el.diagnostic" ]]
--[[]]
--[[ local has_lsp_extensions, ws_diagnostics = pcall(require, "lsp_extensions.workspace.diagnostic") ]]
--[[]]
--[[ local git_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufnr) ]]
--[[   local icon = extensions.file_icon(_, bufnr) ]]
--[[   if icon then ]]
--[[     return icon .. " " ]]
--[[   end ]]
--[[]]
--[[   return "" ]]
--[[ end) ]]
--[[]]
--[[ local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer) ]]
--[[   local branch = extensions.git_branch(window, buffer) ]]
--[[   if branch then ]]
--[[     return " " .. extensions.git_icon() .. " " .. branch ]]
--[[   end ]]
--[[ end) ]]
--[[]]
--[[ local git_changes = subscribe.buf_autocmd("el_git_changes", "BufWritePost", function(window, buffer) ]]
--[[   return extensions.git_changes(window, buffer) ]]
--[[ end) ]]
--[[]]
--[[ local ws_diagnostic_counts = function(_, buffer) ]]
--[[   if not has_lsp_extensions then ]]
--[[     return "" ]]
--[[   end ]]
--[[]]
--[[   local messages = {} ]]
--[[]]
--[[   local error_count = ws_diagnostics.get_count(buffer.bufnr, "Error") ]]
--[[]]
--[[   local x = "⬤" ]]
--[[   if error_count == 0 then ]]
--[[     -- pass ]]
--[[   elseif error_count < 5 then ]]
--[[     table.insert(messages, string.format("%s#%s#%s%%*", "%", "StatuslineError" .. error_count, x)) ]]
--[[   else ]]
--[[     table.insert(messages, string.format("%s#%s#%s%%*", "%", "StatuslineError5", x)) ]]
--[[   end ]]
--[[]]
--[[   return table.concat(messages, "") ]]
--[[ end ]]
--[[]]
--[[ local show_current_func = function(window, buffer) ]]
--[[   if buffer.filetype == "lua" then ]]
--[[     return "" ]]
--[[   end ]]
--[[]]
--[[   return lsp_statusline.current_function(window, buffer) ]]
--[[ end ]]
--[[]]
--[[ local minimal_status_line = function(_, buffer) ]]
--[[   if string.find(buffer.name, "sourcegraph/sourcegraph") then ]]
--[[     return true ]]
--[[   end ]]
--[[ end ]]
--[[]]
--[[ local is_sourcegraph = function(_, buffer) ]]
--[[   if string.find(buffer.name, "sg://") then ]]
--[[     return true ]]
--[[   end ]]
--[[ end ]]
--[[]]
--[[ local diagnostic_display = diagnostic.make_buffer() ]]
--[[]]
--[[ require("el").setup { ]]
--[[   generator = function(window, buffer) ]]
--[[     local is_minimal = minimal_status_line(window, buffer) ]]
--[[     local is_sourcegraph = is_sourcegraph(window, buffer) ]]
--[[]]
--[[     local mode = extensions.gen_mode { format_string = " %s " } ]]
--[[     if is_sourcegraph then ]]
--[[       return { ]]
--[[         { mode }, ]]
--[[         { sections.split, required = true }, ]]
--[[         { builtin.file }, ]]
--[[         { sections.split, required = true }, ]]
--[[         { builtin.filetype }, ]]
--[[       } ]]
--[[     end ]]
--[[]]
--[[     local items = { ]]
--[[       { mode, required = true }, ]]
--[[       { git_branch }, ]]
--[[       { " " }, ]]
--[[       { sections.split, required = true }, ]]
--[[       { git_icon }, ]]
--[[       { sections.maximum_width(builtin.file_relative, 0.60), required = true }, ]]
--[[       { sections.collapse_builtin { { " " }, { builtin.modified_flag } } }, ]]
--[[       { sections.split, required = true }, ]]
--[[       { diagnostic_display }, ]]
--[[       { show_current_func }, ]]
--[[       -- { lsp_statusline.server_progress }, ]]
--[[       -- { ws_diagnostic_counts }, ]]
--[[       { git_changes }, ]]
--[[       { "[" }, ]]
--[[       { builtin.line_with_width(3) }, ]]
--[[       { ":" }, ]]
--[[       { builtin.column_with_width(2) }, ]]
--[[       { "]" }, ]]
--[[       { ]]
--[[         sections.collapse_builtin { ]]
--[[           "[", ]]
--[[           builtin.help_list, ]]
--[[           builtin.readonly_list, ]]
--[[           "]", ]]
--[[         }, ]]
--[[       }, ]]
--[[       { builtin.filetype }, ]]
--[[     } ]]
--[[]]
--[[     local add_item = function(result, item) ]]
--[[       if is_minimal and not item.required then ]]
--[[         return ]]
--[[       end ]]
--[[]]
--[[       table.insert(result, item) ]]
--[[     end ]]
--[[]]
--[[     local result = {} ]]
--[[     for _, item in ipairs(items) do ]]
--[[       add_item(result, item) ]]
--[[     end ]]
--[[]]
--[[     return result ]]
--[[   end, ]]
--[[ } ]]
