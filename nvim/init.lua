require("opts")
require("remaps")
require("plugins")

require("gx_open")
require("statusline")

-- TMP
vim.api.nvim_create_user_command("Today", function()
    local year = tonumber(os.date("%Y"))
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))
    local quarter = math.floor((month - 1) / 3) + 1
    local first_wday = tonumber(os.date("%w", os.time { year = year, month = month, day = 1 }))
    local week_of_month = math.floor((day + first_wday) / 7) + 1

    local file_path = string.format("~/Workspace/zid-worklogs/%s-Q%s/%s.W%s.md", year, quarter, os.date("%b-%d.%a"),
        week_of_month)
    vim.cmd("edit " .. file_path)
end, {})

vim.filetype.add({
    filename = {
        ["Caddyfile"] = "caddy",
    },
})
