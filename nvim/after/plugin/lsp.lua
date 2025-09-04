vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '<leader>v', function()
    vim.diagnostic.config({ virtual_text = false })
end);
vim.keymap.set('n', '<leader>V', function()
    vim.diagnostic.config({ virtual_text = true })
end);


local function prefers_local(local_relative_path, global_cmd, args)
    local cwd = vim.fn.getcwd()
    local local_bin = cwd .. "/" .. local_relative_path

    if vim.fn.executable(local_bin) == 1 then
        return vim.list_extend({ local_bin }, args or {})
    end

    local global_bin = vim.fn.exepath(global_cmd)
    if vim.fn.executable(global_bin) == 1 then
        return vim.list_extend({ global_bin }, args or {})
    end

    return vim.list_extend({ global_cmd }, args or {})
end

require('blink.cmp').setup({
    keymap = { preset = 'super-tab' },
    completion = {
        menu = { border = 'single' },
        keyword = { range = 'full' },
        documentation = { auto_show = true }
    },
    accept = { auto_brackets = { enabled = true }, }, -- Disable if it caused issues
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true }, -- Experimental feature
    cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
    },
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }
        -- these will be buffer-local keybindings
        -- because they only work if you have an active language server
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end
})

vim.lsp.enable('pyright')
vim.lsp.config('pyright', {
    cmd = prefers_local(
        '.venv/bin/pyright-langserver',
        'pyright-langserver',
        { '--stdio' }
    ),
})
vim.lsp.enable('ruff')
vim.lsp.config('ruff', {
    cmd = prefers_local(
        '.venv/bin/ruff',
        'ruff',
        { 'server' }
    ),
})
vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using (most
                -- likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths
                    -- here.
                    -- '${3rd}/luv/library'
                    -- '${3rd}/busted/library'
                }
                -- Or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when working on
                -- your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                -- library = {
                --   vim.api.nvim_get_runtime_file('', true),
                -- }
            }
        })
    end,
    settings = {
        Lua = {}
    }
})
