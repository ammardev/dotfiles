vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.8" },
    { src = "https://github.com/folke/tokyonight.nvim" },
    -- pinned to `master`: `main` is treesitter's rewritten core-API branch,
    -- which drops the `nvim-treesitter.configs` module this config uses
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "master" },
    { src = "https://github.com/numToStr/Comment.nvim" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/NeogitOrg/neogit" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/aserowy/tmux.nvim" },
    { src = "https://github.com/dhruvasagar/vim-table-mode" },
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
    { src = "https://github.com/kylechui/nvim-surround", version = "v3.1.8" },
})

vim.cmd.colorscheme("tokyonight-night")

require("tmux").setup({ copy_sync = { enable = false } })

require("nvim-surround").setup({
    -- Configuration here, or leave empty to use defaults
})

-- nvim-treesitter no longer auto-updates parsers on plugin update (that was
-- lazy.nvim's `build = ":TSUpdate"` hook). Run :TSUpdate by hand after
-- `vim.pack.update()` touches this plugin.
