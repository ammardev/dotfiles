local lspconfig = require('lspconfig');
require("neodev").setup() -- For NeoVim lua autocompletion


vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

vim.keymap.set('n', '<leader>v', function ()
    vim.diagnostic.config({virtual_text=false})
end);

vim.keymap.set('n', '<leader>V', function ()
    vim.diagnostic.config({virtual_text=true})
end);


vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}

        -- these will be buffer-local keybindings
        -- because they only work if you have an active language server
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
    lspconfig[server].setup({
        capabilities = lsp_capabilities,
    })
end

require('mason').setup({})

local ensure_installed = {
    "bashls",
    "docker_compose_language_service",
    "gopls",
    "phpactor",
    "lua_ls",
    "yamlls",
    "ruff",
    "pyright",
}

require('mason-lspconfig').setup({
    ensure_installed = ensure_installed,
    handlers = {
        default_setup,
    },
})

local cmp = require('cmp')

cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
    },
    mapping = cmp.mapping.preset.insert({
        -- Enter key confirms completion item
        ['<CR>'] = cmp.mapping.confirm({select = true}),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

lspconfig.pyright.setup{
    handlers = {
        ['textDocument/publishDiagnostics'] = function() end
    },
    settings = {
        python = {
            pythonPath = ".venv/bin/python"
        },
    },
}

-- TODO: Find a way to get sources directly from Mason
local null_ls = require("null-ls")

null_ls.setup({
    debug = false,
    sources = {
        -- Python
        require("none-ls.formatting.ruff").with({
            prefer_local = "./.venv/bin/",
        }),
        -- PHP
        null_ls.builtins.diagnostics.phpcs,
        null_ls.builtins.formatting.phpcsfixer,
    },
})
