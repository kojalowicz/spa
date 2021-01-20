#!/bin/bash -ex

what_to_test=$1

. /home/vagrant/env.conf

function build_test () {
  set -o pipefail
  cd $work_dir/$source_code_location
  ng e2e
}

function container_test () {
  docker run -it --name $project_name -d -p $docker_port_host:$docker_port_guest $registry_url:$registry_port/$project_name:$project_version
  if curl -I localhost:8080 2>&1 | grep -w "200\|301" ; then
    echo "Test it docker is up - OK, good job :D!"
  else
    echo "Test it docker is up - docker fail :("
    exit 1
  fi
  docker stop $project_name || true && docker rm $project_name || true
}

set -o pipefail
if [[ $what_to_test == "build" ]]; then
  build_test |& tee $logs_dir/$project_name-build-test-$(date --iso-8601=seconds).log
elif [[ $what_to_test == "container" ]]; then
  container_test |& tee $logs_dir/$project_name-container-test-$(date --iso-8601=seconds).log
else
  echo "Wrong parameter choice for test"
fi
