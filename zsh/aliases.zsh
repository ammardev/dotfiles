alias dc="docker-compose"
alias ds="docker stop \$(docker ps -q)"
alias dcu="docker-compose up -d"
function dce() {
    docker-compose exec "$1" "$2"
}
function _dce() {
    services=$(docker-compose config --services 2>/dev/null)
    if [ -z $services ]; then
        echo "This is not a valid Docker Compose folder"
    else
        _arguments "1: :($services)"
    fi
}
compdef _dce dce
alias edit-host="sudo nvim /etc/hosts"
alias check-port="nc -vz"
alias nano="nvim"
alias vi="nvim"
alias vim="nvim"
alias :q="exit"

alias deploy-to-testing="git checkout develop && git fetch && git reset --hard origin/develop && git merge - && git push && git checkout -"
alias gc='git checkout $(git branch | fzf-tmux -h)'

