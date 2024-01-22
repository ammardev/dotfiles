require("default")

-- local LastOpenedWindow

--vim.api.nvim_create_autocmd("FileType", {
--    pattern = "GitReviewTool",
--    callback = function(args)
--        vim.keymap.set('n', '<CR>', function()
--            local selectedLine = vim.api.nvim_get_current_line()
--
--            local index, _ = selectedLine:find('\t')
--
--            vim.cmd('wincmd p')
--            vim.cmd('e ' .. selectedLine:sub(index, -1))
--        end)
--
--        vim.keymap.set('n', 'd', function()
--            local selectedLine = vim.api.nvim_get_current_line()
--
--            local index, _ = selectedLine:find('\t')
--
--            vim.cmd('wincmd p')
--            vim.cmd('e ' .. selectedLine:sub(index, -1))
--
--            vim.cmd('Gvdiffsplit master...HEAD')
--        end)
--    end
--})

vim.api.nvim_create_user_command('Test', function ()
    local handler = io.popen('git diff origin/master...HEAD --name-status')
    local result = ''

    if handler then
        result = handler:read("*a")
        handler:close()
    end

    local files = {}
    for line in result:gmatch('[^\r\n]+') do
        table.insert(files, line)
    end

    vim.cmd('split')
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)

    vim.api.nvim_buf_set_lines(buf, 0, 0, true, files)

    vim.api.nvim_buf_set_name(buf, 'Change List')

    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf, 'filetype', 'GitReviewTool')

    vim.api.nvim_win_set_buf(win, buf)
end, {})

