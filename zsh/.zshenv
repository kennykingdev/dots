export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export EDITOR=nvim
# Required for rootless docker
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
export PATH=/home/kenny/code/scripts:$PATH
