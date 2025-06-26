function do-create --description 'Create DigitalOcean droplet'
    doctl compute droplet create --tag-name=tmp --wait --ssh-keys="$DO_SSH_KEY_ID" --region=fra1 --image=ubuntu-23-10-x64 --size s-1vcpu-2gb $argv[1]
    and echo \a
end