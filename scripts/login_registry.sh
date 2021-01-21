#!/bin/bash -ex

what_to_do=$1

. /home/vagrant/configuration/env.conf
. /home/vagrant/configuration/docker_reg_auth/login

cd /home/vagrant/
mkdir -p /etc/docker/certs.d/$registry_url:$registry_port
cp configuration/docker_reg_certs/domain.crt /etc/docker/certs.d/$registry_url:$registry_port/ca.crt
cp configuration/docker_reg_certs/domain.crt /usr/local/share/ca-certificates/ca.crt
update-ca-certificates

set -o pipefail
if [[ -z $what_to_do ]]; then
  docker login -u$user -p$password $registry_url:$registry_port
elif [[ $what_to_do == "no-login" ]]; then
  echo "update ca certificates done"
else
  echo "Wrong parameter choice for build"
fi
