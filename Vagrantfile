# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.box_check_update = false

  config.vm.network "private_network", type: "dhcp"
  config.vm.network "forwarded_port", guest: 1234, host: 1234
  config.vm.network "forwarded_port", guest: 1235, host: 1235

  config.vm.provision "shell", inline: <<-SHELL
    yum update -y
    yum install -y java-1.8.0-openjdk
    yum install -y lsof strace
    yum clean all


    cd /home/vagrant
    #https://github.com/linkerd/linkerd/releases/download/1.3.4/linkerd-1.3.4-exec
    curl -LJO https://github.com/linkerd/linkerd/releases/download/1.3.5/linkerd-1.3.5-exec
    chmod +x linkerd-1.3.5-exec

    mkdir /home/vagrant/discovery
    chown vagrant:vagrant ./discovery/
    
    sysctl fs.inotify.max_user_instances=128
    sysctl fs.inotify.max_user_watches=0
  SHELL

  config.vm.provision "file", source: "./config.yaml", destination: "/home/vagrant/config.yaml"
end
