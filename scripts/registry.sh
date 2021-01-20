#!/bin/bash -e

. /home/vagrant/env.conf

function run_registry () {
  docker run -d -p $registry_port:$registry_port --restart=always --name $registry_name $registry_name
}

set -o pipefail
run_registry |& tee $logs_dir/$project_name-runig-registry-$(date --iso-8601=seconds).log


# docker run -d -p 5000:5000 --restart=always --name localhost $registry_name