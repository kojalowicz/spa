#!/bin/bash -e

. /home/vagrant/env.conf

if docker  container ls --filter name=$project_name | grep "$project_name" ; then
    echo "Your container is running"
else
    echo "Your container is getting up"
    if docker  container ls --all --filter name=$project_name | grep "$project_name" ; then
        docker stop $project_name || true && docker rm $project_name || true
    fi
    docker run -it --name $project_name -d -p $docker_port_host:$docker_port_guest $registry_url:$registry_port/$project_name:$project_version
fi