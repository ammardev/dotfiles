# Docker Aliases
alias dc="docker compose"
alias ds="docker stop (docker ps -q)"
alias dcu="docker compose up -d"

# VIM Aliases
alias nano="nvim"
alias vi="nvim"
alias vim="nvim"
alias :q="exit"

# Networking Aliases
alias edit-host="sudo nvim /etc/hosts"
alias check-port="nc -vz"

# DigitalOcean Aliases
alias do-list="doctl compute droplet list"
alias do-ssh="doctl compute ssh"
alias do-delete="doctl compute droplet delete"

# Workflow Aliases
alias deploy-to-testing="git checkout develop && git fetch && git reset --hard origin/develop && git merge - && git push && git checkout -"
alias deploy-to-preprod="git checkout preprod && git fetch && git reset --hard origin/preprod && git merge - && git push && git checkout -"

alias cd=z
alias activate-current-ext-backend="rm ~/Workspace/zid/extension-backend ; ln -s $(pwd) ~/Workspace/zid/extension-backend && cp ~/Workspace/zid/ext-be-worktrees/primary/.env ./.env"
alias p="gh pr view --web || gh pr create --web"
