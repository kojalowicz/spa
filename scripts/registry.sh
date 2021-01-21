#!/bin/bash -e

. /home/vagrant/configuration/env.conf

function run_registry () {
  docker run -d -p $registry_port:$registry_port --restart=always --name $registry_name -v $configuration_dir/docker_reg_certs:/certs -v $configuration_dir/docker_reg_auth:/auth -v /reg:/var/lib/registry -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd -e REGISTRY_AUTH=htpasswd $registry_name:$registry_version
}

set -o pipefail
run_registry |& tee $logs_dir/$project_name-runig-registry-$(date --iso-8601=seconds).log