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
                pylint = { enabled = false },
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
