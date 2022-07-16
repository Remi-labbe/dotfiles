local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
    -- Packer updates itself
    use("wbthomason/packer.nvim")

    -- Colorscheme
    use("gruvbox-community/gruvbox")

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    -- Find the way
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Sweet Lsp
    use "neovim/nvim-lspconfig"
    -- use "williamboman/nvim-lsp-installer"
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
    -- snippet engine
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
    use "rafamadriz/friendly-snippets"

    -- Easily comment stuff
    use "numToStr/Comment.nvim"
    use "JoosepAlviste/nvim-ts-context-commentstring"

    use "Pocco81/TrueZen.nvim"
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
