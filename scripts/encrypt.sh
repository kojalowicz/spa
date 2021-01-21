#!/bin/bash -ex

. /home/vagrant/configuration/env.conf
. $configuration_dir/docker_reg_auth/password

apt update
apt install openssl

openssl enc -aes-256-cbc -d -in $configuration_dir/docker_reg_certs/domain.key.enc -out $configuration_dir/docker_reg_certs/domain.key -pass pass:$password
openssl enc -aes-256-cbc -d -in $configuration_dir/docker_reg_certs/domain.crt.enc -out $configuration_dir/docker_reg_certs/domain.crt -pass pass:$password
openssl enc -aes-256-cbc -d -in $configuration_dir/docker_reg_auth/login.enc -out $configuration_dir/docker_reg_auth/login -pass pass:$password
openssl enc -aes-256-cbc -d -in $configuration_dir/docker_reg_auth/htpasswd.enc -out $configuration_dir/docker_reg_auth/htpasswd -pass pass:$password
rm -r $configuration_dir/docker_reg_auth/password
