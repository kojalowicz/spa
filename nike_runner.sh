#!/bin/bash -ex

what_to_do=$1

current_dir=$(pwd)

function up-environment() {
  cd $current_dir/vagrant_file/registry
  vagrant up
  cd $current_dir/vagrant_file/build
  vagrant up
  vagrant destroy -f
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
  vagrant destroy -f
}

set -o pipefail
if [[ -z $what_to_do ]]; then
  up-environment
elif [[ $what_to_do == "down" ]]; then
  down-environment
elif [[ $what_to_do == "test" ]]; then
  test-environment
else
  echo "Wrong parameter choice for build"
fi
