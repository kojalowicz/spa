#!/bin/bash -ex

function set_up_docker () {
  cp /home/vagrant/daemon.json /etc/docker/daemon.json
  systemctl restart docker.socket
  systemctl restart docker
}

set -o pipefail
set_up_docker |& tee $logs_dir/$project_name-set_up_dockerr-$(date --iso-8601=seconds).log
