#!/usr/bin/bash

function main() {
    local container=$1
    local command=$2
    if [[ "$command" != "start" && "$command" != "stop" ]]; then
        echo "command should be start or stop"
        exit 1
    fi
    
    local curl_command="curl --unix-socket /var/run/docker.sock   -X POST http://localhost/v1.43/containers/${container}/${command}"
    $curl_command && sleep 3
}

main $@