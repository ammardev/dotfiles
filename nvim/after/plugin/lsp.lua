local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').pylsp.setup({
    settings = {
        pylsp = {
            configurationSources = {},
            plugins = {
                autopep8 = { enabled = false },
                flake8 = { enabled = false },
                yapf = { enabled = false },
                mccabe = { enabled = false },
                pycodestyle = { enabled = false },
                preload = { enabled = false },
                pyflakes = { enabled = false },
                pylint = {
                    enabled = true,
                    args = {
                        "--max-line-length=88",
                        "--disable=missing-class-docstring,too-few-public-methods,missing-function-docstring,too-many-ancestors",
                        "--load-plugins=pylint_django",
                        "--init-hook=\"import sys;sys.path.insert(0, './pyvendor')\"",
                    },
                },
                jedi_completion = {
                    enabled = true,
                },
                jedi = {
                    extra_paths = {'./pyvendor'},
                }
            },
        },
    }
})

lsp.setup()

local cmp = require('cmp')

cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = true}),
    }
})
