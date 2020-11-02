#!/bin/bash

#Define cleanup procedure
cleanup() {
    echo "stoppping container"
    service ssh stop
    service apache2 stop
}

#Trap SIGTERM
trap 'cleanup' SIGTERM

service apache2 start
service ssh start

/bin/bash