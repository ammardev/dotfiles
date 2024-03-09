##
## Docker Aliases
##
alias dc="docker-compose"
alias ds="docker stop \$(docker ps -q)"
alias dcu="docker-compose up -d"
function dce() {
    docker-compose exec "$1" "$2"
}

##
## VIM Aliases
##
alias nano="nvim"
alias vi="nvim"
alias vim="nvim"
alias :q="exit"

##
## Networking Aliases
##
alias edit-host="sudo nvim /etc/hosts"
alias check-port="nc -vz"

##
## DigitalOcean Aliases
##
alias do-list="doctl compute droplet list"
function do-create() {
    doctl compute droplet create --tag-name=tmp --wait --ssh-keys="$DO_SSH_KEY_ID" --region=fra1 --image=ubuntu-23-10-x64 --size s-1vcpu-2gb $1 && echo $'\a'
}
alias do-ssh="doctl compute ssh"
alias do-delete="doctl compute droplet delete"

##
## Workflow Aliases
##
alias deploy-to-testing="git checkout develop && git fetch && git reset --hard origin/develop && git merge - && git push && git checkout -"
alias gc='git checkout $(git branch | fzf-tmux -h)'

