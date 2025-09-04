_G.buffer_file_icon = function()
    local icon, hl_group = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype, { default = true })
    return ('%%#%s#%s'):format(hl_group or 'StatusLine', icon or '')
end

_G.get_diagnostics_count = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local diagnostics = vim.diagnostic.get(bufnr)

    local counts = { error = 0, warn = 0, info = 0 }
    for _, diag in ipairs(diagnostics) do
        if diag.severity == vim.diagnostic.severity.ERROR then
            counts.error = counts.error + 1
        elseif diag.severity == vim.diagnostic.severity.WARN then
            counts.warn = counts.warn + 1
        elseif diag.severity == vim.diagnostic.severity.INFO then
            counts.info = counts.info + 1
        end
    end

    local parts = {}
    if counts.error > 0 then table.insert(parts, "%#DiagnosticSignError#" .. "󰅚 " .. counts.error) end
    if counts.warn > 0 then table.insert(parts, "%#DiagnosticSignWarn#" .. "󰀪 " .. counts.warn) end
    if counts.info > 0 then table.insert(parts, "%#DiagnosticSignInfo#" .. "󰌶 " .. counts.info) end
    table.insert(parts, "%#StatusLine#")
    return table.concat(parts, " ")
end


local statusline = {
    '%#StatusLine#',
    '%r',
    '%{%v:lua.buffer_file_icon()%}%#StatusLine# ',
    '%{fnamemodify(expand("%"), ":.")}',
    -- TODO: Add LSP status
    '%m',
    '%=',
    '%3l:%-2c',
    ' %{get(b:, "gitsigns_head", "")}',
    '%{get(b:, "gitsigns_status", "")}',
    '%{%v:lua.get_diagnostics_count()%}',
    ' ',
}
vim.o.statusline = table.concat(statusline, ' ')
