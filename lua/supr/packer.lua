vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use 'wbthomason/packer.nvim'

    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }}
    use { 'nvim-telescope/telescope-fzf-native.nvim',
          run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }
    use { 'LukasPietzschmann/telescope-tabs', requires = { 'nvim-telescope/telescope.nvim' } }
    use { 'navarasu/onedark.nvim', as = 'onedark' }
    use { 'rebelot/kanagawa.nvim', as = 'kanagawa' }
    use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }}
    use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons' }}
    use { 'numToStr/Comment.nvim' }
    use { 'folke/flash.nvim' }

    use { 'neovim/nvim-lspconfig' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lua' }

    use { 'j-hui/fidget.nvim', tag = 'legacy' }
    use { 'junegunn/fzf' }
    use { 'junegunn/fzf.vim' }
    use { 'nvim-lua/lsp-status.nvim' }
    use { 'ray-x/lsp_signature.nvim' }
    use { 'onsails/lspkind.nvim' }
end)
