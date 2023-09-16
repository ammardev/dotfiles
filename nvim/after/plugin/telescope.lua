local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>/', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', function()
	if not pcall(builtin.git_files) then
		builtin.find_files()
	end
end)
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})

