#!/bin/bash

# Destroy the old vagrand machine (optional) and provision a new one
vagrant destroy
vagrant up


# Gene
generate_requests(){
    echo -e "\nGenerating requests!\n"
    for i in `seq 129`; do
        curl -X POST --data {foo=bar} curl --proxy 127.0.0.1:1235 http://someservice.test &
    done
}
(sleep 10 && generate_requests)&


# Start Linkerd in Vagrant
vagrant ssh -c "./linkerd-1.3.5-exec ./config.yaml"