local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup {
  renderer = {
    highlight_opened_files = "none",
    root_folder_label = ":t",
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      web_devicons = {
        file = {
          enable = true,
          color = true,
        },
        folder = {
          enable = false,
          color = true,
        },
      },
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = " ",
      info = " ",
      warning = " ",
      error = " ",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    side = "left",
    number = true,
    relativenumber = true,
  },
  -- mappings = {
  --   custom_only = false,
  --   list = {
  --     { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
  --     { key = "h",                  cb = tree_cb "close_node" },
  --     { key = "v",                  cb = tree_cb "vsplit" },
  --   },
  -- },
}
