#!/bin/bash -e

. /home/vagrant/env.conf

function requirements () {
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub|sudo apt-key add -
  echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list
  apt update
  apt-get install -y nodejs npm google-chrome-stable
  npm install -g @angular/cli --unsafe-perm=true
}

requirements |& tee $logs_dir/$project_name-requirements-instalation-$(date --iso-8601=seconds).log
