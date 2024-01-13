local mason_lspconfig = require('mason-lspconfig')

local ensure_installed = {
    "bashls",
    "docker_compose_language_service",
    "gopls",
    "intelephense",
    "lua_ls",
    "pylsp",
    "tsserver",
    "yamlls",
}

mason_lspconfig.setup { ensure_installed = ensure_installed }

vim.api.nvim_create_user_command("MasonInstallDefault", function ()
  vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
end, {})
