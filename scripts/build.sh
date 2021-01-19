#!/bin/bash -e

. /home/vagrant/env.conf

cd /home/vagrant
git clone $git_clone_commend
cd $work_dir/$source_code_location
npm install
npm run build
. $work_dir/scripts/tests.sh build
cd $work_dir
docker build -t $registry_url:$registry_port/$project_name:$project_version .
. $work_dir/scripts/tests.sh container
docker push $registry_url:$registry_port/$project_name:$project_version
cd ~/
rm -r $work_dir