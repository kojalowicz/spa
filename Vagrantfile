Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.provision :docker
  config.vm.network "private_network", ip: "192.168.10.11"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.provision "file", source: "./configuration/env.conf", destination: "/home/vagrant/env.conf"
  config.vm.provision :shell, path: "./scripts/requirements.sh"
  config.vm.provision :shell, path: "./scripts/registry.sh"
  config.vm.provision :shell, path: "./scripts/build.sh"
  config.vm.provision :shell, path: "./scripts/just_do_it.sh", run: "always"
end
