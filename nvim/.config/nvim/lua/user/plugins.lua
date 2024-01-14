local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Colorscheme
  "ellisonleao/gruvbox.nvim",
  "rebelot/kanagawa.nvim",

  "kyazdani42/nvim-web-devicons",

  'lewis6991/impatient.nvim',
  -- "j-hui/fidget.nvim",

  "nvim-lualine/lualine.nvim",

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- event = { "LazyFile", "VeryLazy" },
  },

  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",

  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    version = '*'                     -- optional, updated every week. (see issue #1193)
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  'windwp/nvim-ts-autotag',

  -- Find the way
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  "nvim-telescope/telescope-file-browser.nvim",
  "nvim-telescope/telescope-ui-select.nvim",

  -- git
  -- { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' },

  {
    'lewis6991/gitsigns.nvim',
    -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  },
  { "akinsho/toggleterm.nvim", version = "*" },

  -- Sweet Lsp
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "ray-x/lsp_signature.nvim",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-path",
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh"
  },
  "onsails/lspkind-nvim",
  "nvim-lua/lsp_extensions.nvim",
  -- use "glepnir/lspsaga.nvim"
  "L3MON4D3/LuaSnip", -- snippet engine
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",
  "jose-elias-alvarez/null-ls.nvim",

  -- Easily comment stuff
  "numToStr/Comment.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- Debugging
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "folke/trouble.nvim",

  -- Java
  "mfussenegger/nvim-jdtls",

  -- Rust
  "simrat39/rust-tools.nvim",

  -- Typescript
  "jose-elias-alvarez/typescript.nvim",

  -- Typescript
  "jose-elias-alvarez/typescript.nvim",

  -- Make things easier to see
  "RRethy/vim-illuminate",
  "norcalli/nvim-colorizer.lua",
  "gpanders/editorconfig.nvim",
})
-- local fn = vim.fn
-- local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
--     install_path })
-- end
--
--
-- return require('packer').startup(function(use)
--   use "wbthomason/packer.nvim"
--   use "rebelot/kanagawa.nvim"
--
--   use "nvim-lualine/lualine.nvim"
--
--   use {
--     "nvim-treesitter/nvim-treesitter",
--     run = ":TSUpdate",
--   }
--
--   use "nvim-lua/popup.nvim"
--   use "nvim-lua/plenary.nvim"
--
--   -- Sweet Lsp
--   use "neovim/nvim-lspconfig"
--   use "williamboman/mason.nvim"
--   use "williamboman/mason-lspconfig.nvim"
--   use "ray-x/lsp_signature.nvim"
--   use "hrsh7th/cmp-nvim-lsp"
--   use "hrsh7th/cmp-buffer"
--   use "hrsh7th/nvim-cmp"
--   use "hrsh7th/cmp-path"
--   use {
--     "tzachar/cmp-tabnine",
--     run = "./install.sh"
--   }
--   use "onsails/lspkind-nvim"
--   use "nvim-lua/lsp_extensions.nvim"
--   -- use "glepnir/lspsaga.nvim"
--   use "L3MON4D3/LuaSnip" -- snippet engine
--   use "saadparwaiz1/cmp_luasnip"
--   use "rafamadriz/friendly-snippets"
--   use "jose-elias-alvarez/null-ls.nvim"
--
--   use "jose-elias-alvarez/typescript.nvim"
--
--   use "numToStr/Comment.nvim"
--   -- Automatically set up your configuration after cloning packer.nvim
--   -- Put this at the end after all plugins
--   if PACKER_BOOTSTRAP then
--     require('packer').sync()
--   end
--
-- end)
