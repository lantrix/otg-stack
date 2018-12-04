# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.define :otgstack_dev
  config.vm.provider :virtualbox
  config.vm.provision "file", source: "docker-compose.yml", destination: "docker-compose.yml"
  config.vm.provision "shell", inline: <<-SHELL
    apt-get -y update
    apt-get -y install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    apt-key fingerprint 0EBFCD88
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get -y update
    apt-get -y install docker-ce
    apt-get -y install docker-compose
    docker-compose up
  SHELL
end