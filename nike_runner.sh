#!/bin/bash -ex

what_to_do=$1
debug_module=$2

current_dir=$(pwd)

function up-environment() {
  cd $current_dir/vagrant_file/registry
  vagrant up
  cd $current_dir/vagrant_file/build
  vagrant up
  if [[ -z $debug_module ]]; then
    vagrant destroy
  elif [[ $debug_module == "debug" ]]; then
    echo "Virtual machines will be left to debug."
  fi
  cd $current_dir/vagrant_file/service
  vagrant up
}

function down-environment() {
  cd $current_dir/vagrant_file/registry
  vagrant destroy -f
  cd $current_dir/vagrant_file/build
  vagrant destroy -f
  cd $current_dir/vagrant_file/service
  vagrant destroy -f

}

function test-environment() {
  cd $current_dir/vagrant_file/test
  vagrant up
}

function test-environment-down() {
  cd $current_dir/vagrant_file/test
  vagrant destroy -f
}

set -o pipefail
if [[ $what_to_do == "up" ]]; then
  echo "Enter the password for encryption:"
  read -s password
  echo "password=$password" > ./configuration/docker_reg_auth/password
  up-environment
elif [[ $what_to_do == "down" ]]; then
  down-environment
elif [[ $what_to_do == "test" ]]; then
  test-environment
elif [[ $what_to_do == "test-down" ]]; then
  test-environment-down
else
  echo "Wrong parameter choice for build"
fi

