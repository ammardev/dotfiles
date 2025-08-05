local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd("colorscheme tokyonight-night")
        end
    },
    { "nvim-treesitter/nvim-treesitter", build = "TSUpdate"},
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = "nvim-treesitter/nvim-treesitter",
    },
    { "tpope/vim-fugitive" },
    {
        "airblade/vim-gitgutter",
        config = function()
            vim.cmd("set updatetime=100")
        end
    },
    {
        'jwalton512/vim-blade',
        lazy = true,
        event = "BufReadPre *.blade.php"
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' }, -- Optional remove if not needed
        -- use a release tag to download pre-built binaries
        version = '1.*',
        opts_extend = { "sources.default" }
    },
    { 'neovim/nvim-lspconfig', },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
    },
    {
        "aserowy/tmux.nvim",
        config = function() return require("tmux").setup({copy_sync = { enable = false } }) end
    },
    {'APZelos/blamer.nvim'},
    {
        'dhruvasagar/vim-table-mode',
        lazy = true,
        event = "BufReadPre *.md"
    },
    {"lukas-reineke/indent-blankline.nvim", main="ibl"},
    {"github/copilot.vim"},
})
