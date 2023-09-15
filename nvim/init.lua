if vim.env.VIM_MODE == 'DB' then
    print('Database mode')
else
    require("default")
end

