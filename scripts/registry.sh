#!/bin/bash -e

. /home/vagrant/env.conf

docker run -d -p $registry_port:$registry_port --restart=always --name $registry_name $registry_name
