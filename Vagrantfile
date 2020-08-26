# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "master" do |web|
    web.vm.box = "centos/7"
  end

  config.vm.define "agent" do |db|
    db.vm.box = "centos/7"
  end
end
