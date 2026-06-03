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
        'nvim-telescope/telescope.nvim',
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
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", branch = "main", },
    { "numToStr/Comment.nvim" },
    { "NeogitOrg/neogit" , dependencies = {"sindrets/diffview.nvim"} },
    { "lewis6991/gitsigns.nvim" },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' }, -- Optional remove if not needed
        -- use a release tag to download pre-built binaries
        version = '1.*',
        opts_extend = { "sources.default" }
    },
    { 'neovim/nvim-lspconfig', },
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    {
        "aserowy/tmux.nvim",
        config = function() return require("tmux").setup({ copy_sync = { enable = false } }) end
    },
    {
        'dhruvasagar/vim-table-mode',
        lazy = true,
        event = "BufReadPre *.md"
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
    {
        "kylechui/nvim-surround",
        version = "^3.0.0",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
})

