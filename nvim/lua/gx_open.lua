vim.ui._original_open = vim.ui._original_open or vim.ui.open
vim.ui.open = function(uri, opts)
    opts = opts or {}

    local jira_handler = function(u)
        return "https://zid-dev.atlassian.net/browse/" .. u
    end

    local handlers = {
        ["^CR%-"] = jira_handler,
        ["^INCIDENT%-"] = jira_handler,
    }

    for pattern, handler in pairs(handlers) do
        if uri:match(pattern) then
            uri = handler(uri)
            break
        end
    end

    print(uri)
    vim.ui._original_open(uri, opts)
end
