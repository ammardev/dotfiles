function dce --description 'Docker compose exec wrapper'
    docker compose exec $argv[1] $argv[2..-1]
end