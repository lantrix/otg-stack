# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.define :otgstack_dev
  config.vm.provider :virtualbox
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 443, host: 443
  config.vm.provision "file", source: "docker-compose.yml", destination: "docker-compose.yml"
  config.vm.provision "shell", path: "provision/docker.sh"
  config.vm.provision "shell", path: "provision/otg-stack.sh"
end