local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

return require('packer').startup(function(use)
    -- Packer updates itself
    use("wbthomason/packer.nvim")

    -- Colorscheme
    -- use("gruvbox-community/gruvbox")
    use "ellisonleao/gruvbox.nvim"
    use "folke/tokyonight.nvim"

    use "kyazdani42/nvim-web-devicons"

    use 'lewis6991/impatient.nvim'
    use "j-hui/fidget.nvim"

    use "nvim-telescope/telescope-file-browser.nvim"
    use "nvim-telescope/telescope-ui-select.nvim"
    use "nvim-lualine/lualine.nvim"

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    -- Find the way
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

    -- Sweet Lsp
    use "neovim/nvim-lspconfig"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "ray-x/lsp_signature.nvim"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-path"
    use {
        "tzachar/cmp-tabnine",
        run = "./install.sh"
    }
    use "onsails/lspkind-nvim"
    use "nvim-lua/lsp_extensions.nvim"
    use "glepnir/lspsaga.nvim"
    use "L3MON4D3/LuaSnip" -- snippet engine
    use "saadparwaiz1/cmp_luasnip"
    use "rafamadriz/friendly-snippets"
    use "jose-elias-alvarez/null-ls.nvim"

    -- Easily comment stuff
    use "numToStr/Comment.nvim"
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Debugging
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "folke/trouble.nvim"

    -- Java
    use "mfussenegger/nvim-jdtls"

    -- Rust
    use "simrat39/rust-tools.nvim"

    -- Make things easier to see
    use "RRethy/vim-illuminate"
    use "norcalli/nvim-colorizer.lua"

    use "Pocco81/TrueZen.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
