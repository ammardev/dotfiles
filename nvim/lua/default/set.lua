--
-- General Settings
--
vim.g.mapleader = " "
vim.opt.wrap = false
vim.opt.colorcolumn = "120" -- TODO: Change depending on the file type
vim.opt.list = true
vim.opt.hidden = true -- Allow change the buffer without saving

--
-- Line numbering
--
vim.opt.nu = true
vim.opt.relativenumber=true


--
-- Indentations
--
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

--
-- Search settings
--
vim.opt.ignorecase = true
vim.opt.smartcase = true

--
-- Diagnostic Settings
--
vim.opt.signcolumn = "yes" -- Always keep space for signs
vim.fn.sign_define('DiagnosticSignWarn', { text = "", texthl="DiagnosticSignWarn" })
vim.fn.sign_define('DiagnosticSignError', { text = "", texthl="DiagnosticSignError" })
vim.fn.sign_define('DiagnosticSignInfo', { text = "", texthl="DiagnosticSignInfo" })
vim.diagnostic.config({ severity_sort = true })

