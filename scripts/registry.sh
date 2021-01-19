#!/bin/bash -e

. /home/vagrant/env.conf

function run_registry () {
  docker run -d -p $registry_port:$registry_port --restart=always --name $registry_name $registry_name
}

run_registry |& tee $logs_dir/$project_name-runig-registry-$(date).log