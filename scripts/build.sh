#!/bin/bash -ex

what_to_do=$1

. /home/vagrant/env.conf

function build () {
  cd /home/vagrant
  git clone $git_clone_commend
  cd $work_dir/$source_code_location
  npm install
  npm run build
  . $work_dir/scripts/tests.sh build
  cd $work_dir
  docker build -t $registry_url:$registry_port/$project_name:$project_version .
  . $work_dir/scripts/tests.sh container
}

function docker_push() {
  docker push $registry_url:$registry_port/$project_name:$project_version
}

# docker run -d -e REGISTRY_HTTP_ADDR=192.168.10.12:5000 -p 5000:5000 --name registry registry
set -o pipefail
if [[ -z $what_to_do ]]; then
  (build && docker_push) |& tee $logs_dir/$project_name-build-full-$(date --iso-8601=seconds).log
elif [[ $what_to_do == "test" ]]; then
  build |& tee $logs_dir/$project_name-just-build-$(date --iso-8601=seconds).log
else
  echo "Wrong parameter choice for build"
fi