require("opts")
require("remaps")
require("plugins")

require("gx_open")
require("statusline")

vim.filetype.add({
    filename = {
        ["Caddyfile"] = "caddy",
    },
})
