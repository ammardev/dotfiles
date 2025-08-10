-- Open file explorer
vim.keymap.set("n", "<leader>f", vim.cmd.Ex)

-- Moving selected code easily
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- Past to system clipboard
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")
vim.keymap.set("v", "<leader>P", "\"+P")

-- Delete/Cut to system clipboard
vim.keymap.set("n", "<leader>d", "\"+d")
vim.keymap.set("v", "<leader>d", "\"+d")

-- Git Keymaps
vim.keymap.set("n", "gG", ":Neogit kind=floating<CR>")
vim.keymap.set("n", "]g", ":Gitsigns nav_hunk next<CR>")
vim.keymap.set("n", "[g", ":Gitsigns nav_hunk prev<CR>")

-- Enable <ESC> to exit insert mode in terminal
vim.api.nvim_set_keymap("t", "<ESC>", "<C-\\><C-n>", {noremap = true})
